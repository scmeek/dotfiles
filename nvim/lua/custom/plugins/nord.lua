return {
    'shaunsingh/nord.nvim',
    config = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        vim.g.nord_disable_background = true

        require('nord').set()

        vim.cmd.colorscheme 'nord'
    end,
}
