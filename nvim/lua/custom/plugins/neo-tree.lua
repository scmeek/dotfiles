return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    keys = {
        { '<leader>t', ':Neotree reveal=true toggle<CR>', desc = 'Toggle Neo-[T]ree', },
    },
    config = function()
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
        vim.cmd([[ let g:nvim_tree_quit_on_open = 0 ]]) -- Doesn't play well with barbar

        vim.fn.sign_define('DiagnosticSignError',
            { text = ' ', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn',
            { text = ' ', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo',
            { text = ' ', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint',
            { text = '', texthl = 'DiagnosticSignHint' })

        require('neo-tree').setup({
            close_if_last_window = true,
            sort_case_insensitive = true,
            default_component_configs = {
                git_status = {
                    symbols = {
                        modified = "", -- Remove redundant symbol
                    },
                },
            }
        })
    end,
}
