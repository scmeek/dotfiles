local constants = require('constants')

local local_group = vim.api.nvim_create_augroup('Local', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Trim whitespace on save',
    group = local_group,
    pattern = '*',
    command = ':%s/\\s\\+$//e',
})

vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})

function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            return
        end
    end
    vim.diagnostic.open_float({
        scope = 'line',
        show_header = false,
        border = constants.border_style,
        severity_sort = true,
        focusable = false,
        close_events = {
            'CursorMoved',
            'CursorMovedI',
            'BufHidden',
            'InsertCharPre',
            'WinLeave',
        },
    })
end

vim.api.nvim_create_augroup('lsp_diagnostics_hold', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    pattern = '*',
    callback = OpenDiagnosticIfNoFloat,
    group = 'lsp_diagnostics_hold',
})

vim.api.nvim_create_user_command('ToggleVerboseLogging', function()
    if (vim.opt.verbose:get() == 0) then
        print('Enabling verbose logging')
        vim.opt.verbosefile = vim.fn.expand('~/log/vim/verbose.log')
        vim.opt.verbose = 15
    else
        print('Disabling verbose logging')
        vim.opt.verbose = 0
        vim.opt.verbosefile = nil
    end
end, {})
