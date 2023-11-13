vim.g.undotree_HighlightChangedWithSign = 0
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SetFocusWhenToggle = 1

return {
	"mbbill/undotree",
	event = "VeryLazy",
	keys = {
		{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle [U]ndotree" },
	},
}
