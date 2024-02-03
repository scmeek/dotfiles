-- NOTE: This could be converted to use mrcjkb/rustaceanvim instead, which adds
-- additional tooling
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local rust_analyzer_config_file = vim.fn.getcwd() .. "/.rust-analyzer.json"
local rust_analyzer_config_file_handler = io.open(rust_analyzer_config_file, "r")

local settings = {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				command = "clippy",
			},
		},
	},
}

if rust_analyzer_config_file_handler ~= nil then
	local config_json = rust_analyzer_config_file_handler:read("*a")
	rust_analyzer_config_file_handler:close()

	local config = vim.json.decode(config_json) or nil
	if config ~= nil then
		settings.settings = {
			["rust-analyzer"] = config,
		}
	end
end

return settings
