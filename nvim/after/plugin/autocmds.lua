local local_group = vim.api.nvim_create_augroup('Local', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Temporarily highlight text on yank',
    group = local_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch' })
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Trim whitespace on save',
    group = local_group,
    pattern = '*',
    command = ':%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd('VimLeave', {
    desc = 'Set cursor to blinking horizontal when leaving neovim',
    group = local_group,
    pattern = '*',
    command = 'set guicursor=a:hor25-blinkon10',
})

