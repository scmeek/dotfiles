vim.keymap.set('n', '<leader>tn', ':TestNearest<cr>')
vim.keymap.set('n', '<leader>tf', ':TestFile<cr>')
vim.keymap.set('n', '<leader>ts', ':TestSuite<cr>')
vim.keymap.set('n', '<leader>tl', ':TestLast<cr>')
vim.keymap.set('n', '<leader>tgf', ':TestVisit<cr>') -- Go to last run test file

vim.g['test#strategy'] = 'neovim' -- Runs test commands with `:terminal` in a split window
