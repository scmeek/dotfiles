return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		local formatters = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			lua = { "stylua" },
			python = { "black", "isort" },
			rust = { "rustfmt" },
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
			"less",
			"markdown",
			"scss",
			--"typescript",  -- handled by null-ls and eslint
			"vue",
			"yaml",
		}

		for _, filetype in pairs(prettier_filetypes) do
			formatters[filetype] = { "prettierd" }
		end

		local options = {
			lsp_fallback = false,

			formatters_by_ft = formatters,

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
				async = false,
				quiet = true,
			},
		}

		require("conform").setup(options)
	end,
}
