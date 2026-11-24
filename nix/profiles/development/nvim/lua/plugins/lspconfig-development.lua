return {
  "neovim/nvim-lspconfig",
  optional = true,
  opts = {
    servers = {
      clangd = { mason = false },
      pyright = { mason = false },
      taplo = { mason = false },
      yamlls = { mason = false },
    },
  },
}
