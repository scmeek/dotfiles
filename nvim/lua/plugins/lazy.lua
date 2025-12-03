vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
    vim.cmd("highlight EndOfBuffer ctermbg=NONE guibg=NONE")
  end,
})

return {
  {
    "LazyVim/LazyVim",
    -- opts = { colorscheme = "OceanicNext" },
  },
}
