vim.g.bufferline = {
    animation = true,
    closable = true,
    icon_separator_active = '',
    icon_separator_inactive = '',
}

vim.keymap.set('n', '<leader>,', ':BufferPrevious<CR>')
vim.keymap.set('n', '<leader>.', ':BufferNext<CR>')
vim.keymap.set('n', '<leader>1', ':BufferGoto 1<CR>')
vim.keymap.set('n', '<leader>2', ':BufferGoto 2<CR>')
vim.keymap.set('n', '<leader>3', ':BufferGoto 3<CR>')
vim.keymap.set('n', '<leader>4', ':BufferGoto 4<CR>')
vim.keymap.set('n', '<leader>5', ':BufferGoto 5<CR>')
vim.keymap.set('n', '<leader>6', ':BufferGoto 6<CR>')
vim.keymap.set('n', '<leader>7', ':BufferGoto 7<CR>')
vim.keymap.set('n', '<leader>8', ':BufferGoto 8<CR>')
vim.keymap.set('n', '<leader>9', ':BufferGoto 9<CR>')
vim.keymap.set('n', '<leader>0', ':BufferLast<CR>')
vim.keymap.set('n', '<leader>c', ':BufferClose<CR>')
vim.keymap.set('n', '<leader>p', ':BufferPick<CR>')
