-- Add Mason binaries directory to Neovim's internal PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "arduino-language-server",
      "bacon",
      "bacon-ls",
      "bash-language-server",
      "black",
      "clang-format",
      "clangd",
      "codelldb",
      "css-lsp",
      "debugpy", -- nvim-dap-python (from the Python extra) uses debugpy-adapter
      "eslint-lsp",
      "html-lsp",
      "isort",
      "lua-language-server",
      "prettier",
      "pyright",
      "rust-analyzer",
      "shellcheck",
      "shfmt",
      "stylua",
      "taplo",
      "tailwindcss-language-server",
      "typescript-language-server",
      "yaml-language-server",
      "yamllint",
      "yamlfmt",
    },
  },
}
