return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format()
			end,
			desc = "Format",
		},
	},
	config = function()
		local formatters = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			glsl = { "glsl_analyzer" },
			--ino = { "clang-format" },
			lua = { "stylua" },
			python = { "black", "isort" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			toml = { "taplo" },
			yaml = { "yamlfmt" },
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

		for _, filetype in pairs(prettier_filetypes) do
			formatters[filetype] = { "prettier" }
		end

		local lsp_fallback = true
		local options = {
			lsp_fallback = lsp_fallback,
			formatters_by_ft = formatters,
			format_on_save = {
				timeout_ms = 1500,
				lsp_fallback = lsp_fallback,
				quiet = true,
			},
		}

		require("conform").setup(options)
	end,
}
