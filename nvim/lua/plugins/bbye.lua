return {
	"moll/vim-bbye",
	event = "VeryLazy",
	cmd = { "Bdelete", "Bwipeout" },
	keys = {
		{ "<C-w>", vim.cmd.Bdelete, desc = "[C-w] Close buffer" },
	},
}
