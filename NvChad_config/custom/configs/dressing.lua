local constants = require("custom.constants")

return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			enabled = true,
			default_prompt = "➤ ",
			win_options = {
				winblend = 0,
			},
			border = constants.default_border,
		},
		select = {
			enabled = true,
			backend = { "telescope", "builtin" },
			builtin = {
				win_options = {
					winblend = 0,
				},
			},
			border = constants.default_border,
		},
	},
}
