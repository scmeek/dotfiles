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

        local icons = require('icons')
        for type, icon in pairs(icons.diagnostics) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        require('neo-tree').setup({
            close_if_last_window = true,
            sort_case_insensitive = true,
            default_component_configs = {
                modified = {
                    symbol = icons.status.modified,
                    highlight = "NeoTreeModified",
                },
                git_status = {
                    symbols = {
                        modified  = '', -- Remove redundant symbol
                        ignored   = '',
                        untracked = '',
                        unstaged  = '',
                        staged    = icons.git.Added,
                        conflict  = icons.git.Confict,
                    },
                },
                icon = icons.file_tree,
            },
            filesystem = {
                filtered_items = {
                    visible = false,
                    never_show = {
                        '.DS_Store',
                        'thumbs.db'
                    },
                },
            },
        })
    end,
}
