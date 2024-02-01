return {
	"hrsh7th/nvim-cmp",
	opts = function()
		local opts = require("plugins.configs.cmp")

		table.insert(opts.sources, { name = "copilot" })

		return opts
	end,
}
