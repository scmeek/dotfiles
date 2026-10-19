return {
  "stevearc/conform.nvim",
  optional = true,
  opts = function(_, opts)
    local formatters = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      toml = { "taplo" },
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
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, formatters)
    opts.formatters = opts.formatters or {}
    opts.formatters.rustfmt = vim.tbl_deep_extend("force", opts.formatters.rustfmt or {}, {
      command = vim.fs.joinpath(vim.fs.dirname(vim.fn.exepath("rustup")), "rustfmt"),
      cwd = function(_, ctx) return ctx.dirname end,
    })
  end,
}
