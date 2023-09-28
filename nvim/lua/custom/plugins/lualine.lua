local icons = require('icons')

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = icons.status_bar.component_separators,
            section_separators = icons.status_bar.section_separators,
            fmt = string.lower,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                {
                    'filename',
                    newfile_status = true,
                    path = 1,
                    symbols = {
                        unnamed = 'untitled',
                        newfile = 'untitled',
                        modified = icons.status.modified,
                        readonly = icons.status.readonly,
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
