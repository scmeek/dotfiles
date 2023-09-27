return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  keys = {
    { '<leader>l', ':lua require("lsp_lines").toggle()<CR>', desc = 'Toggle [L]sp lines' },
  },
  config = function()
    require('lsp_lines').setup()
  end,
}
