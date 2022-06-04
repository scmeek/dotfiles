require('Comment').setup({
    padding = false, -- Do not add space
    toggler = {
        line = '<leader>//',
        block = nil,
    },
    opleader = {
        line = nil,
        block = '<leader>/',
    },
    mappings = {
        basic = true,
        extra = false,
        extended = false,
    },
})
