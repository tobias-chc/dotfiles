return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    open_mapping = [[<leader>t]],
    start_in_insert = true,
    persist_mode = false,
    direction = 'float',
    float_opts = {
      border = 'rounded',
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
    },
    -- Fix exit keybindings
    on_open = function(term)
      local opts = { buffer = term.bufnr, noremap = true, silent = true }
      -- Exit terminal mode and close window
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('n', 'q', ':q<CR>', opts)
      vim.keymap.set('n', '<esc>', ':q<CR>', opts)
      -- avoid conflict with toggleterm open mapping
      vim.keymap.set('t', '<leader>t', ' t', opts)
    end,
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)
  end,
}
