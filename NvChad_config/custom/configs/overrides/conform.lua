return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		local formatters = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			lua = { "stylua" },
			python = { "black", "isort" },
			sh = { "shfmt" },
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
			"typescript",
			"vue",
			"yaml",
		}

		for _, filetype in pairs(prettier_filetypes) do
			formatters[filetype] = { "prettier" }
		end

		local options = {
			lsp_fallback = true,

			formatters_by_ft = formatters,

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
				async = false,
				quiet = true,
			},
		}

		require("conform").setup(options)
	end,
}
