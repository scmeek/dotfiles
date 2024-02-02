return {
	"hrsh7th/nvim-cmp",
	opts = function()
		local cmp = require("cmp")
		local opts = require("plugins.configs.cmp")

		opts.preselect = cmp.PreselectMode.None
		opts.completion.completeopt = "menu,menuone,noselect,noinsert"

		table.insert(opts.sources, { name = "copilot" })

		opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })

		return opts
	end,
}
