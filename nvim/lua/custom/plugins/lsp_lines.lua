return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  keys = {
    { '<leader>l', function() require('lsp_lines').toggle() end, desc = 'Toggle [L]SP lines' },
  },
  config = function()
    require('lsp_lines').setup()
  end,
}
