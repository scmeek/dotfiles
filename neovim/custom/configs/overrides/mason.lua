return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"arduino-language-server",
			"bash-language-server",
			"clang-format",
			"clangd",
			"css-lsp",
			"eslint-lsp",
			"html-lsp",
			"lua-language-server",
			"prettier",
			"rust-analyzer",
			--"rustfmt",  -- Deprecated, use rustup to install
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
