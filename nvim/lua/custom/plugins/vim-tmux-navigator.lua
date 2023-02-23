return {
	'christoomey/vim-tmux-navigator',
	keys = {
		{ '<leader>|', '<C-W>v', desc = 'Split [|] vertical' },
		{ '<leader>-', '<C-W>s', desc = 'Split [-] horizontal' },
		{ '<C-h>', '<C-W>h', desc = 'Go to previous split' },
		{ '<C-j>', '<C-W>j', desc = 'Go down a split' },
		{ '<C-k>', '<C-W>k', desc = 'Go up a split' },
		{ '<C-l>', '<C-W>l', desc = 'Go to next split' },
	}
}
