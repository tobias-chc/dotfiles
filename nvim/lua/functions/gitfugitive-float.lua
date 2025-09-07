vim.api.nvim_create_user_command('Gfloat', function()
  vim.cmd 'Git' -- open Fugitive status in a split

  local src_win = vim.api.nvim_get_current_win()
  local status_buf = vim.api.nvim_get_current_buf()

  -- Open the status buffer in a floating window
  local float_win = vim.api.nvim_open_win(status_buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    row = math.floor(vim.o.lines * 0.1),
    col = math.floor(vim.o.columns * 0.1),
    style = 'minimal',
    border = 'rounded',
  })

  -- Close the original split
  if vim.api.nvim_win_is_valid(src_win) and src_win ~= float_win then
    pcall(vim.api.nvim_win_close, src_win, true)
  end

  -- Autocmd group for <Esc> behavior
  local grp = vim.api.nvim_create_augroup('GfloatEsc', { clear = true })

  -- Whenever we enter a buffer in the float
  vim.api.nvim_create_autocmd('BufEnter', {
    group = grp,
    callback = function(args)
      if not vim.api.nvim_win_is_valid(float_win) then
        return
      end
      if vim.api.nvim_get_current_win() ~= float_win then
        return
      end

      local buf = args.buf

      vim.keymap.set('n', '<Esc>', function()
        if buf == status_buf then
          -- In status buffer → close the whole float
          if vim.api.nvim_win_is_valid(float_win) then
            vim.api.nvim_win_close(float_win, true)
          end
        else
          -- In a file buffer → switch back and delete this buffer
          if vim.api.nvim_buf_is_valid(status_buf) then
            vim.api.nvim_win_set_buf(float_win, status_buf)
          end
          if vim.api.nvim_buf_is_valid(buf) then
            pcall(vim.api.nvim_buf_delete, buf, { force = false })
          end
        end
      end, { buffer = buf, nowait = true, silent = true, noremap = true })
    end,
  })
end, {})

-- When you're in a Fugitive buffer, redirect any new window to a fresh float
do
  local grp = vim.api.nvim_create_augroup('FugitiveOpenInFloat', { clear = true })

  vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    group = grp,
    callback = function(args)
      local new_win = vim.api.nvim_get_current_win()
      local new_buf = args.buf

      -- Previous window (where the command came from)
      local prev_win = vim.fn.win_getid(vim.fn.winnr '#')
      if prev_win == 0 or not vim.api.nvim_win_is_valid(prev_win) then
        return
      end

      -- Only if we came from a fugitive buffer
      local prev_buf = vim.api.nvim_win_get_buf(prev_win)
      local prev_ft = vim.bo[prev_buf].filetype
      local from_fugitive = (prev_ft == 'fugitive' or prev_ft == 'fugitiveblame')
      if not from_fugitive then
        return
      end

      -- If the new thing is itself a fugitive status, let it be (you might be using :Git)
      local new_ft = vim.bo[new_buf].filetype
      if new_ft == 'fugitive' or new_ft == 'fugitiveblame' then
        return
      end

      -- Compute a nice floating size/position (centered; tweak to taste)
      local W, H = vim.o.columns, vim.o.lines
      local width = math.floor(W * 0.8)
      local height = math.floor(H * 0.8)
      local row = math.floor((H - height) / 2)
      local col = math.floor((W - width) / 2)

      -- Open the new buffer in a float
      local float_win = vim.api.nvim_open_win(new_buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
      })

      -- Close the split that just popped up
      if new_win ~= float_win and vim.api.nvim_win_is_valid(new_win) then
        pcall(vim.api.nvim_win_close, new_win, true)
      end

      -- Quality of life: <Esc> closes this float (buffer-local)
      vim.keymap.set('n', '<Esc>', function()
        if vim.v.hlsearch == 1 then
          vim.cmd 'nohlsearch'
        else
          if vim.api.nvim_win_is_valid(float_win) then
            vim.api.nvim_win_close(float_win, true)
          end
        end
      end, { buffer = new_buf, silent = true, nowait = true, noremap = true })
    end,
  })
end
