local local_group = vim.api.nvim_create_augroup('Local', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Trim whitespace on save',
    group = local_group,
    pattern = '*',
    command = ':%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    callback = function()
        vim.diagnostic.open_float({ scope = 'line' })
    end,
})

vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})
