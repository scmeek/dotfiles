---@type NvPluginSpec[]
local plugins = {
	require("custom.configs.overrides.cmp"),
	require("custom.configs.overrides.conform"),
	require("custom.configs.overrides.lspconfig"),
	require("custom.configs.overrides.mason"),
	require("custom.configs.overrides.nvimtree"),
	require("custom.configs.overrides.treesitter"),

	require("custom.configs.copilot"),
	require("custom.configs.copilotcmp"),
	require("custom.configs.dressing"),
	require("custom.configs.lastplace"),
	require("custom.configs.neorg"),
	require("custom.configs.signature"),
	require("custom.configs.surround"),
	require("custom.configs.targets"),
	require("custom.configs.todocomments"),
	require("custom.configs.tmuxnavigator"),
}

return plugins
