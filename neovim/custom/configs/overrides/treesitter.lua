return {
	"nvim-treesitter/nvim-treesitter",
	opts = function()
		local opts = require("plugins.configs.treesitter")
		opts.ensure_installed = {
			"bash",
			"c",
			"css",
			"cpp",
			"glsl",
			"html",
			"javascript",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
		}
		opts.indent = {
			enable = true,
			-- disable = {
			--   "python"
			-- },
		}
		return opts
	end,
	init = function()
		local glsl_filetypes = { "comp", "frag", "geom", "glsl", "tesc", "tese", "vert" }
		local extensions = {}
		for _, glsl_filetype in pairs(glsl_filetypes) do
			extensions[glsl_filetype] = "glsl"
		end

		vim.filetype.add({
			extension = extensions,
		})
	end,
}
