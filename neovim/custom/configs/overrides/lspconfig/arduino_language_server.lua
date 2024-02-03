local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local arduino_cli_config_file = os.getenv("HOME") .. "/.arduino15/arduino-cli.yaml"
local arduino_cli_config_file_handler = io.open(arduino_cli_config_file, "r")

local settings = {
	on_attach = on_attach,
	capabilities = capabilities,
}

if arduino_cli_config_file_handler ~= nil then
	arduino_cli_config_file_handler:close()

	settings.cmd = {
		"arduino-language-server",
		"-cli-config",
		arduino_cli_config_file,
		"-cli",
		"arduino-cli",
		"-clangd",
		"clangd",
		"-fqbn",
		"arduino:avr:uno",
	}
else
	print(
		"WARN: Missing arduino-cli configuration file while configuring "
			.. "arduino-language-server ("
			.. arduino_cli_config_file
			.. ")"
	)
end

return settings
