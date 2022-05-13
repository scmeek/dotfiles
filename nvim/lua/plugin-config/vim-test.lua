vim.keymap.set('n', '<leader>tn', ':TestNearest<cr>')
vim.keymap.set('n', '<leader>tf', ':TestFile<cr>')
vim.keymap.set('n', '<leader>ts', ':TestSuite<cr>')
vim.keymap.set('n', '<leader>tl', ':TestLast<cr>')
vim.keymap.set('n', '<leader>tgf', ':TestVisit<cr>') -- Go to last run test file

-- Sends test commands to neovim terminal using a terminal managed by harpoon.
-- By default commands are sent to terminal number 1, you can choose your
-- terminal by setting `g:test#harpoon_term` with the terminal you want.
vim.g['test#strategy'] = 'harpoon'
