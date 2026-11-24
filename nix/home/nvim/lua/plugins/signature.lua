-- Show marks in gutter
return {
  "kshenoy/vim-signature",
  event = "VeryLazy",
  init = function()
    -- Use the plugin's setting so its own ColorScheme handler cannot undo it.
    vim.g.SignatureMarkTextHL = "DiffAdd"
  end,
}
