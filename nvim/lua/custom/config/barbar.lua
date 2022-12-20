vim.g.bufferline = {
    animation = true,
    auto_hide = true,
    closable = true,
    icon_separator_active = '│',
    icon_separator_inactive = '│',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    icon_pinned = '車',
    insert_at_start = true,
    maximum_padding = 0,
}

vim.keymap.set('n', 'gt', ':BufferNext<CR>', { desc = 'Go to next [t] buffer' })
vim.keymap.set('n', 'gT', ':BufferPrevious<CR>', { desc = 'Go to previous [T] buffer' })
vim.keymap.set('n', '<leader>1', ':BufferGoto 1<CR>', { desc = 'Go to [1]st buffer' })
vim.keymap.set('n', '<leader>2', ':BufferGoto 2<CR>', { desc = 'Go to [2]nd buffer' })
vim.keymap.set('n', '<leader>3', ':BufferGoto 3<CR>', { desc = 'Go to [3]rd buffer' })
vim.keymap.set('n', '<leader>4', ':BufferGoto 4<CR>', { desc = 'Go to [4]th buffer' })
vim.keymap.set('n', '<leader>5', ':BufferGoto 5<CR>', { desc = 'Go to [5]th buffer' })
vim.keymap.set('n', '<leader>6', ':BufferGoto 6<CR>', { desc = 'Go to [6]th buffer' })
vim.keymap.set('n', '<leader>7', ':BufferGoto 7<CR>', { desc = 'Go to [7]th buffer' })
vim.keymap.set('n', '<leader>8', ':BufferGoto 8<CR>', { desc = 'Go to [8]th buffer' })
vim.keymap.set('n', '<leader>9', ':BufferGoto 9<CR>', { desc = 'Go to [9]th buffer' })
vim.keymap.set('n', '<leader>0', ':BufferLast<CR>', { desc = 'Go to [0] last buffer' })
vim.keymap.set('n', '<leader>w', ':BufferClose<CR>', { desc = '[W] Close buffer' })
vim.keymap.set('n', '<leader>p', ':BufferPick<CR>', { desc = '[P]ick buffer' })

vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function()
        if vim.bo.filetype == 'NvimTree' then
            -- custom_filetree_offset assigned in init.lua
            require('bufferline.api').set_offset(vim.g.custom_filetree_offset, '')
        end
    end,
})

vim.api.nvim_create_autocmd('BufWinLeave', {
    pattern = '*',
    callback = function()
        if vim.fn.expand('<afile>'):match('NvimTree') then
            require('bufferline.api').set_offset(0)
        end
    end,
})
