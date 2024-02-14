return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			lsp_doc_border = true, -- add a border to hover docs and signature help
			long_message_to_split = true, -- long messages will be sent to a split
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
