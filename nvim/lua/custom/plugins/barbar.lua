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
        require('bufferline').setup({
            animation = false,
            closable = false,
            icons = 'both',
            icon_separator_active = '│',
            icon_separator_inactive = '│',
            insert_at_end = true,
            no_name_title = 'Untitled',
        })
    end,
}
