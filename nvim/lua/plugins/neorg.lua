return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.completion"] = {
						config = { engine = "nvim-cmp" },
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Documents/notes/neorg",
							},
						},
					},
				},
			})
		end,
	},
}
