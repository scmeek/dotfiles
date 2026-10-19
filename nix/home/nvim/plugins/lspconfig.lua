return {
  "neovim/nvim-lspconfig",
  optional = true,
  -- Nix supplies these servers; LazyVim still configures and enables them.
  opts = { servers = { lua_ls = { mason = false }, bashls = { mason = false } } },
}
