return {
	"saecki/crates.nvim",
	ft = { "rust", "toml" },
	tag = "stable",
	config = function(_, opts)
		local crates = require("crates")
		crates.setup(opts)
		crates.show()
	end,
}
