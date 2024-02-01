return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			-- lua stuff
			"lua-language-server",
			"stylua",

			-- web dev stuff
			"css-lsp",
			"html-lsp",
			"typescript-language-server",
			"prettier",

			-- c/cpp stuff
			"clangd",
			"clang-format",
		},
	},
}
