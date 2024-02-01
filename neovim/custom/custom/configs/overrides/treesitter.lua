return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"css",
			"cpp",
			"html",
			"javascript",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
		},
		indent = {
			enable = true,
			-- disable = {
			--   "python"
			-- },
		},
	},
}
