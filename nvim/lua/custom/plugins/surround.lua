return {
  'kylechui/nvim-surround',
  version = '*',
  event = 'VeryLazy', -- Note: Forces redraw which makes neovim intro screen disappear
  config = function()
    require('nvim-surround').setup()
  end,
}
