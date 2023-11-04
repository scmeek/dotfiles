local formatters = {
  lua = { 'stylua' },
}

local prettier_filetypes = {
  'angular',
  'css',
  'flow',
  'graphql',
  'html',
  'json',
  'jsx',
  'javascript',
  'less',
  'markdown',
  'scss',
  'typescript',
  'vue',
  'yaml',
}

for _, filetype in pairs(prettier_filetypes) do
  formatters[filetype] = { 'prettier' }
end

return {
  'stevearc/conform.nvim',
  opts = {
    format_on_save = {
      async = false,
      quiet = true,
      lsp_fallback = true,
    },
    formatters_by_ft = formatters,
  },
}
