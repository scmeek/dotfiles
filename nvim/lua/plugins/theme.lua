return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 900, -- init.lua is 1000, which this should override
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			background = {
				light = "latte",
				dark = "macchiato",
			},
		})
		vim.cmd.colorscheme("catppuccin")
		local hl_groups = { "DiagnosticUnderlineError" }
		for _, hl in ipairs(hl_groups) do
			vim.cmd.highlight(hl .. " gui=undercurl")
		end
	end,
}
