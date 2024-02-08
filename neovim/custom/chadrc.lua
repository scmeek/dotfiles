---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "tokyonight",
	theme_toggle = { "tokyonight", "gruvbox_light" },

	hl_override = highlights.override,
	hl_add = highlights.add,

	nvdash = {
		load_on_startup = true,
		buttons = {
			{ "  Find File", "<leader> + ff", "Telescope find_files" },
			{ "󰈚  Recent Files", "<leader> + fo", "Telescope oldfiles" },
			{ "󰈭  Find Word", "<leader> + fw", "Telescope live_grep" },
			{ "  Bookmarks", "<leader> + ma", "Telescope marks" },
			{ "  Themes", "<leader> + th", "Telescope themes" },
			{ "  Mappings", "<leader> + ch", "Open cheatsheet" },
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
