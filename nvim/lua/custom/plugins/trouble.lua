require('which-key').register({
	['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
})

return {
	'folke/trouble.nvim',
	keys = {
		{ '<leader>xx', '<cmd>TroubleToggle<cr>',                       desc = '[xx] Toggle Trouble' },
		{ '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = '[xw] Trouble workspace diagnostics' },
		{ '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',  desc = '[xd] Trouble document diagnostics' },
		{ '<leader>xl', '<cmd>TroubleToggle loclist<cr>',               desc = '[xl] Trouble location list' },
		{ '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',              desc = '[xq] Trouble quickfix items' },
		{ 'gR',         '<cmd>TroubleToggle lsp_references<cr>',        desc = 'Troup LSP [R]eferences' },
	},
}
