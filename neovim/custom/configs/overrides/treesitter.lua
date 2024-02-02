return {
	"nvim-treesitter/nvim-treesitter",
	opts = function()
		local opts = require("plugins.configs.treesitter")
		opts.ensure_installed = {
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
		}
		opts.indent = {
			enable = true,
			-- disable = {
			--   "python"
			-- },
		}
		return opts
	end,
}
