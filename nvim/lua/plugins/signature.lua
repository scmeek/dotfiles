-- Show marks in gutter
return {
  "kshenoy/vim-signature",
  event = "VeryLazy",
  init = function()
    vim.g.SignatureMarkTextHL = "DiffAdd" -- Use the plugin's setting so its own ColorScheme handler cannot undo it.
  end,
}
