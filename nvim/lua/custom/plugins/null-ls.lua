return {
	'jose-elias-alvarez/null-ls.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	config = function()
		local shell_filetypes = { 'sh', 'zsh' }
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		local null_ls = require('null-ls')
		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.shellcheck.with({ filetypes = shell_filetypes }),
				null_ls.builtins.formatting.shfmt.with({ filetypes = shell_filetypes }),
				null_ls.builtins.formatting.eslint_d,
			},
		})
	end,
}
