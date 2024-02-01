---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "tokyonight",
	theme_toggle = { "tokyonight", "one_light" },

	hl_override = highlights.override,
	hl_add = highlights.add,

	nvdash = {
		load_on_startup = true,
		buttons = {
			{ "  Find File", "<leader> f f", "Telescope find_files" },
			{ "󰈚  Recent Files", "<leader> f o", "Telescope oldfiles" },
			{ "󰈭  Find Word", "<leader> f w", "Telescope live_grep" },
			{ "  Bookmarks", "<leader> m a", "Telescope marks" },
			{ "  Themes", "<leader> t h", "Telescope themes" },
			{ "  Mappings", "<leader> c h", "NvCheatsheet" },
		},
	},

	statusline = {
		theme = "minimal",
		separator_style = "block",
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
