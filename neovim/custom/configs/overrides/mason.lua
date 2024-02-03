return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"clang-format",
			"clangd",
			"css-lsp",
			"eslint-lsp",
			"html-lsp",
			"lua-language-server",
			"prettierd",
			"rust-analyzer",
			--"rustfmt",  -- Deprecated, use rustup to install
			"stylua",
			"taplo",
			"tailwindcss-language-server",
			"typescript-language-server",
		},
	},
}
