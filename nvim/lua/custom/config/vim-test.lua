vim.keymap.set('n', '<leader>tn', ':TestNearest<cr>', { desc = '[T]est [N]earest' })
vim.keymap.set('n', '<leader>tf', ':TestFile<cr>', { desc = '[T]est [F]ile' })
vim.keymap.set('n', '<leader>ts', ':TestSuite<cr>', { desc = '[T]est [S]uite' })
vim.keymap.set('n', '<leader>tl', ':TestLast<cr>', { desc = '[T]est [L]ast' })
vim.keymap.set('n', '<leader>tgf', ':TestVisit<cr>', { desc = '[T]est [G]o to last run [F]ile' })

-- Sends test commands to neovim terminal using a terminal managed by harpoon.
-- By default commands are sent to terminal number 1, you can choose your
-- terminal by setting `g:test#harpoon_term` with the terminal you want.
vim.g['test#strategy'] = 'harpoon'
