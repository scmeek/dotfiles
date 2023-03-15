return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
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
                        modified = '*',
                        readonly = '[-]',
                        unnamed = 'untitled',
                        newfile = 'untitled',
                    },
                },
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        extensions = {
            'toggleterm',
        },
    },
}
