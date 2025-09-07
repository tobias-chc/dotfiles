return {
  'shaunsingh/nord.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- Example config in lua
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = false
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    -- Load the colorscheme
    require('nord').set()

    -- Toggle bg transparency
    local atom_dark_bg_color = '#282c34'

    local function set_background(color)
      vim.api.nvim_set_hl(0, 'Normal', { bg = color })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = color })
    end

    local function toggle_transparency()
        vim.g.nord_disable_background = not vim.g.nord_disable_background
        vim.cmd [[colorscheme nord]]
      if not vim.g.nord_disable_background then
        set_background(atom_dark_bg_color)
      end
    end

    -- Set initial background
    set_background(atom_dark_bg_color)

    -- Set keybinding
    vim.keymap.set('n', '<leader>bg', toggle_transparency, {
      noremap = true,
      silent = true,
      desc = 'Toggle background transparency',
    })
  end,
}
