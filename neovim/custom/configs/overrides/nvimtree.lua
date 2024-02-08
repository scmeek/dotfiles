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
