vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    view = {
        width = function()
            return vim.g.custom_filetree_offset
        end,
    },
})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file [E]xplorer' })

vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})
