return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
    },
  },
}
