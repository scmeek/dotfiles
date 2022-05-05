require('formatter').setup({
    filetype = {
        lua = {
            function()
                return {
                    exe = 'stylua',
                    args = {
                        '--quote-style AutoPreferSingle',
                        '--indent-type Spaces',
                        '-',
                    },
                    stdin = true,
                }
            end,
        },
    },
})

vim.keymap.set('n', '<leader>f', ':Format<cr>')

local formatter_group = vim.api.nvim_create_augroup('Formatter', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Format on save',
    group = formatter_group,
    pattern = '*',
    command = ':FormatWrite',
})
