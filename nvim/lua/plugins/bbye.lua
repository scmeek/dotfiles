return {
  'moll/vim-bbye',
  event = 'VeryLazy',
  cmd = { 'Bdelete', 'Bwipeout' },
  keys = {
    { '<C-c>', vim.cmd.Bdelete, desc = '[W] Close buffer' },
  },
}
