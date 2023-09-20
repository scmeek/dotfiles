return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 900, -- init.lua is 1000, which this should override
  config = function()
    require('catppuccin').setup()
    vim.cmd.colorscheme 'catppuccin'
  end,

}
