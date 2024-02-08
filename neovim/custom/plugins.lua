---@type NvPluginSpec[]
local plugins = {
	require("custom.configs.overrides.cmpconfig"),
	require("custom.configs.overrides.commentconfig"),
	require("custom.configs.overrides.conformconfig"),
	require("custom.configs.overrides.gitsigns"),
	require("custom.configs.overrides.lspconfig"),
	require("custom.configs.overrides.mason"),
	require("custom.configs.overrides.nvimtree"),
	require("custom.configs.overrides.treesitter"),

	require("custom.configs.copilot"),
	require("custom.configs.copilotcmp"),
	require("custom.configs.crates"),
	require("custom.configs.dressing"),
	require("custom.configs.fugitive"),
	require("custom.configs.lastplace"),
	require("custom.configs.nullls"),
	require("custom.configs.signature"),
	require("custom.configs.surround"),
	require("custom.configs.targets"),
	require("custom.configs.tmuxnavigator"),
	require("custom.configs.todocomments"),
	require("custom.configs.tsautotag"),
	require("custom.configs.wordmotion"),
}

return plugins
