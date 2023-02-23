return {
    'rcarriga/nvim-notify',
    config = function()
        require('notify').setup({
            render = 'compact',
            stages = 'static',
            timeout = 2500,
        })
    end,
}