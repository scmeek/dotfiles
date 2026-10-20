return {
  "mason-org/mason.nvim",
  optional = true,
  opts = function(_, opts)
    local supplied_by_nix = {
      ["bacon"] = true,
      ["rust-analyzer"] = true,
      ["rustfmt"] = true,
      ["clang-format"] = true,
      ["clangd"] = true,
      ["black"] = true,
      ["debugpy"] = true,
      ["isort"] = true,
      ["pyright"] = true,
      ["prettier"] = true,
      ["taplo"] = true,
      ["yaml-language-server"] = true,
      ["yamlfmt"] = true,
      ["yamllint"] = true,
    }
    opts.ensure_installed = vim.tbl_filter(function(name)
      return not supplied_by_nix[name]
    end, opts.ensure_installed or {})
    vim.list_extend(opts.ensure_installed, {
      "arduino-language-server",
      "css-lsp",
      "eslint-lsp",
      "html-lsp",
      "tailwindcss-language-server",
      "bacon-ls",
    })
  end,
}
