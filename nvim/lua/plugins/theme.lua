return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 900, -- init.lua is 1000, which this should override
	config = function()
		require("catppuccin").setup({
			background = {
				light = "latte",
				dark = "macchiato",
			},
			flavour = "macchiato",
			integrations = {
				cmp = true,
				dap = {
					enabled = true,
					enable_ui = true,
				},
				gitsigns = true,
				harpoon = true,
				indent_blankline = {
					enabled = true,
				},
				lsp_saga = true,
				lsp_trouble = true,
				mason = true,
				noice = true,
				notify = true,
				which_key = true,
			},
			transparent_background = true,
		})
		vim.cmd.colorscheme("catppuccin")

		local hl_groups = { "DiagnosticUnderlineError" }
		for _, hl in ipairs(hl_groups) do
			vim.cmd.highlight(hl .. " gui=undercurl")
		end
	end,
}
