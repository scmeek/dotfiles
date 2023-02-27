return {
    'rcarriga/nvim-notify',
    config = function()
        require('notify').setup({
            render = 'compact',
            stages = 'fade',
            timeout = 2500,
            background_colour = '#000000',
        })
        vim.notify = require('notify')
    end,
}
