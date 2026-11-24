return {
  "saecki/crates.nvim",
  tag = "stable",
  ft = { "rust", "toml" },
  opts = {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
}
