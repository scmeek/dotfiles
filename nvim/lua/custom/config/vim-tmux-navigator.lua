-- Easier splits handling
vim.keymap.set('n', '<leader>|', '<C-W>v', { silent = true, desc = 'Split [|] vertical' })
vim.keymap.set('n', '<leader>-', '<C-W>s', { silent = true, desc = 'Split [-] horizontal' })
vim.keymap.set('n', '<leader>>', '<C-W>>', { silent = true, desc = 'Go to [>] next split' })
vim.keymap.set('n', '<leader><', '<C-W><', { silent = true, desc = 'Go to [<] previous split' })
