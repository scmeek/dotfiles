require('nvim-tree').setup({})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
