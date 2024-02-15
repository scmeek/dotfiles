local constants = require("custom.constants")

return {
	"timtro/glslView-nvim",
	ft = constants.glsl_filetypes,
	keys = {
		{
			"<leader>gv",
			":GlslView<CR>",
			{
				noremap = true,
				silent = true,
			},
			ft = constants.glsl_filetypes,
			desc = "Open in GlslViewer",
		},
	},
}
