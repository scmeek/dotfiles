vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    view = {
        width = vim.g.custom_filetree_offset, -- custom_filetree_offset assigned in init.lua
    },
})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
