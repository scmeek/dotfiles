require('harpoon').setup({
    nav_first_in_list = true,
})

vim.keymap.set('n', '<leader>hm', ':lua require("harpoon.mark").add_file()<CR>')
vim.keymap.set('n', '<leader>hum', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set('n', '<leader>hcm', ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')

vim.keymap.set('n', '<leader>j', ':lua require("harpoon.ui").nav_file(1)<CR>')
vim.keymap.set('n', '<leader>k', ':lua require("harpoon.ui").nav_file(2)<CR>')
vim.keymap.set('n', '<leader>l', ':lua require("harpoon.ui").nav_file(3)<CR>')
vim.keymap.set('n', '<leader>;', ':lua require("harpoon.ui").nav_file(4)<CR>')
