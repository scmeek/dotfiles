local constants = require('constants')
return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    keys = {
        { '<leader>r',  ':Neotree position=left reveal=true toggle<CR>',  desc = 'Toggle Neo-t[r]ee', },
        { '<leader>rf', ':Neotree position=float reveal=true toggle<CR>', desc = 'Open Neo-t[r]ee [f]loat', },
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
            popup_border_style = constants.border_style,
            sort_case_insensitive = true,
            default_component_configs = {
                modified = {
                    symbol = icons.status.modified,
                    highlight = 'NeoTreeModified',
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
            nesting_rules = {
                ['js'] = { 'cjs', 'cjs.map', 'js.map' },
                ['jsx'] = { 'module.css', 'module.scss', 'scss' },
                ['ts'] = { 'ts.map' },
                ['d.ts'] = { 'd.ts.map' },
                ['tsx'] = { 'module.css', 'module.scss', 'scss' },
            },
            event_handlers = {
                { -- Auto close on open file
                    event = 'file_opened',
                    handler = function(file_path)
                        require('neo-tree.command').execute({ action = 'close' })
                    end
                },
                { -- Equalize window sizes on Neo-tree open
                    event = 'neo_tree_window_after_open',
                    handler = function(args)
                        if args.position == 'left' or args.position == 'right' then
                            vim.cmd('wincmd =')
                        end
                    end
                },
                { -- Equalize window sizes on Neo-tree close
                    event = 'neo_tree_window_after_close',
                    handler = function(args)
                        if args.position == 'left' or args.position == 'right' then
                            vim.cmd('wincmd =')
                        end
                    end
                },
            },
        })

        vim.api.nvim_create_augroup("neotree", {})
        vim.api.nvim_create_autocmd("UiEnter", {
            desc = "Open Neotree automatically",
            group = "neotree",
            callback = function()
                if (vim.fn.argc()) == 0 then
                    vim.defer_fn(
                        function()
                            vim.cmd "Neotree position=float toggle"
                        end,
                        0
                    )
                end
            end,
        })
    end,
}
