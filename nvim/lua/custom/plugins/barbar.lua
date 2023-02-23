return {
    'romgrk/barbar.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { 'gt', ':BufferNext<CR>', desc = '[t] Go to next buffer' },
        { 'gT', ':BufferPrevious<CR>', desc = '[T] Go to previous buffer' },
        { '<leader>1', ':BufferGoto 1<CR>', desc = 'Go to [1]st buffer' },
        { '<leader>2', ':BufferGoto 2<CR>', desc = 'Go to [2]nd buffer' },
        { '<leader>3', ':BufferGoto 3<CR>', desc = 'Go to [3]rd buffer' },
        { '<leader>4', ':BufferGoto 4<CR>', desc = 'Go to [4]th buffer' },
        { '<leader>5', ':BufferGoto 5<CR>', desc = 'Go to [5]th buffer' },
        { '<leader>6', ':BufferGoto 6<CR>', desc = 'Go to [6]th buffer' },
        { '<leader>7', ':BufferGoto 7<CR>', desc = 'Go to [7]th buffer' },
        { '<leader>8', ':BufferGoto 8<CR>', desc = 'Go to [8]th buffer' },
        { '<leader>9', ':BufferGoto 9<CR>', desc = 'Go to [9]th buffer' },
        { '<leader>0', ':BufferLast<CR>', desc = 'Go to [0] last buffer' },
        { '<leader>w', ':BufferClose<CR>', desc = '[W] Close buffer' },
        { '<leader>p', ':BufferPick<CR>', desc = '[P]ick buffer' },
    },
    config = function()
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
    end,
}
