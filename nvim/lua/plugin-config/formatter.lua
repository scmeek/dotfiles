local prettier_default = {
    function()
        return {
            exe = 'prettier',
            args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
            stdin = true,
        }
    end,
}

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
        javascript = prettier_default,
        markdown = prettier_default,
        typescript = prettier_default,
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