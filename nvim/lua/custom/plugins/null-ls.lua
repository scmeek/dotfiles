local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

return {
	'jose-elias-alvarez/null-ls.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	config = function()
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		local null_ls = require('null-ls')
		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,

				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.prettier,
			},
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				if client.supports_method('textDocument/formatting') then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd('BufWritePre', {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
}
