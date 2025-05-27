-- Show marks in gutter
return {
  "kshenoy/vim-signature",
  event = "VeryLazy",
  init = function()
    vim.api.nvim_set_hl(0, "SignatureMarkText", { link = "DiffAdd" })
  end,
}
