require('harpoon').setup({
    nav_first_in_list = true,
})

vim.keymap.set('n', '<leader>hm', ':lua require("harpoon.mark").add_file()<CR>', { desc = '[H]arpoon - Add [M]ark' })
vim.keymap.set(
    'n',
    '<leader>hum',
    ':lua require("harpoon.ui").toggle_quick_menu()<CR>',
    { desc = '[H]arpoon - Toggle [U]I [M]enu' }
)
vim.keymap.set(
    'n',
    '<leader>hcm',
    ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>',
    { desc = '[H]arpoon - Toggle [C]md [U]I Menu' }
)

vim.keymap.set(
    'n',
    '<leader>j',
    ':lua require("harpoon.ui").nav_file(1)<CR>',
    { desc = 'Harpoon - Go to [J] 1st file' }
)
vim.keymap.set(
    'n',
    '<leader>k',
    ':lua require("harpoon.ui").nav_file(2)<CR>',
    { desc = 'Harpoon - Go to [K] 2nd file' }
)
vim.keymap.set(
    'n',
    '<leader>l',
    ':lua require("harpoon.ui").nav_file(3)<CR>',
    { desc = 'Harpoon - Go to [L] 3rd file' }
)
vim.keymap.set(
    'n',
    '<leader>;',
    ':lua require("harpoon.ui").nav_file(4)<CR>',
    { desc = 'Harpoon - Go to [;] 4th file' }
)
