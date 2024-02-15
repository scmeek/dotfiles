-- Manual install GitHub nolanderc/glsl_analyzer ($HOME/.local/bin)

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local constants = require("custom.constants")

local extensions = {}
for _, filetype in ipairs(constants.glsl_filetypes) do
	extensions[filetype] = filetype
end

vim.filetype.add({
	extension = extensions,
})

return {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "glsl_analyzer" },
	filetypes = constants.glsl_filetypes,
	single_file_support = true,
}
