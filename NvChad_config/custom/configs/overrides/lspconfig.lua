local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local default_config_servers = {
	"bashls",
	"clangd",
	"cssls",
	"html",
	"pyright",
	"rust_analyzer",
	"tsserver",
	"vimls",
	"yamlls",
}

return {
	"neovim/nvim-lspconfig",
	config = function()
		require("plugins.configs.lspconfig")
		for _, lsp in ipairs(default_config_servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end
	end,
}
