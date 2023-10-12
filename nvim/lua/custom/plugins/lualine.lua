local constants = require('constants')
local icons = require('icons')

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            fmt = string.lower,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    sections = { 'error', 'warn' },
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                },
            },
            lualine_c = {
                {
                    'filename',
                    newfile_status = true,
                    path = 1,
                    symbols = {
                        modified = icons.status.modified,
                        readonly = icons.status.readonly,
                        unnamed = constants.newfile_name,
                        newfile = constants.newfile_name,
                    },
                },
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        extensions = {
            'neo-tree',
            'toggleterm',
        },
    },
}
