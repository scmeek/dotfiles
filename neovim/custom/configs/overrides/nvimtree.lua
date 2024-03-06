-- https://github.com/nvim-tree/nvim-tree.lua/wiki/FAQ#why-do-i-see-spelling-highlights
vim.api.nvim_set_hl(0, "NvimTreeExecFile", { link = "Question" })
vim.api.nvim_set_hl(0, "NvimTreeSymlink", { link = "MoreMsg" })
vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { link = "Question" })
vim.api.nvim_set_hl(0, "NvimTreeImageFile", { fg = "#ff80ff" })

return {
	"nvim-tree/nvim-tree.lua",
	opts = {
		git = {
			enable = true,
			show_on_dirs = false,
		},

		view = {
			width = 40,
			preserve_window_proportions = false,
		},

		renderer = {
			highlight_opened_files = "name",
			icons = {
				git_placement = "signcolumn",
				show = {
					folder_arrow = false,
					git = true,
				},
			},
		},
		diagnostics = {
			enable = true,
			severity = {
				min = vim.diagnostic.severity.WARN,
				max = vim.diagnostic.severity.ERROR,
			},
		},
		filters = {
			custom = {
				"^.git$",
			},
		},
		actions = {
			change_dir = {
				enable = false,
				restrict_above_cwd = true,
			},
			open_file = {
				resize_window = true,
			},
		},
	},
}
