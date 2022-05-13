require('lualine').setup({
    options = {
        theme = 'nightfly',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            {
                'mode',
                fmt = function(str)
                    return str:sub(1, 1):lower()
                end,
            },
        },
        lualine_b = { { 'tabs' } },
        lualine_c = {
            { 'filetype', icon_only = true },
            {
                'filename',
                path = 1, -- 1 = relative path
                symbols = {
                    modified = '*', -- Text to show when the file is modified.
                    readonly = '[readonly]', -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '--', -- Text to show for unnamed buffers.
                },
            },
        },
        lualine_x = {},
        lualine_y = {
            { 'progress', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = { 'branch', 'diff' },
    },
})