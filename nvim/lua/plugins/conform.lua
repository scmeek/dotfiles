return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    local formatters = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      sh = { "shfmt" },
      toml = { "taplo" },
      zsh = { "shfmt" },
    }

    local prettier_filetypes = {
      "angular",
      "css",
      "flow",
      "graphql",
      "html",
      "json",
      "jsx",
      "javascript",
      "javascriptreact",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "vue",
      "yaml",
    }

    for _, filetype in ipairs(prettier_filetypes) do
      formatters[filetype] = { "prettier" }
    end

    opts.formatters_by_ft = opts.formatters_by_ft or {}
    for filetype, names in pairs(formatters) do
      opts.formatters_by_ft[filetype] = names
    end
  end,
}
