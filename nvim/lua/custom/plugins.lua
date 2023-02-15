-- Get `require` statement for corresponding config file
local function get_config(name)
    return string.format('require("custom/config/%s")', name)
end

return function(use)
    use('arcticicestudio/nord-vim')

    use({
        'folke/which-key.nvim',
        config = get_config('which-key'),
    })

    -- Improve startup time by caching lua modules
    use({
        'lewis6991/impatient.nvim',
        config = get_config('impatient'),
    })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    })

    use({
        'mhartington/formatter.nvim',
        config = get_config('formatter'),
    })

    use({
        'simrat39/rust-tools.nvim',
        config = get_config('rust-tools'),
        requires = {
            'simrat39/rust-tools.nvim',
        },
    })

    use({
        'ThePrimeagen/Harpoon',
        config = get_config('harpoon'),
        requires = {
            'nvim-lua/plenary.nvim',
        },
    })

    -- Tabline
    use({
        'romgrk/barbar.nvim',
        config = get_config('barbar'),
        requires = { 'kyazdani42/nvim-web-devicons' },
    })

    -- File explorer
    use({
        'kyazdani42/nvim-tree.lua',
        config = get_config('nvim-tree'),
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    })

    -- Test runner
    use({
        'vim-test/vim-test',
        config = get_config('vim-test'),
    })

    -- Documentation generator
    use({
        'kkoomen/vim-doge',
        config = get_config('doge'),
    })

    use({
        'norcalli/nvim-colorizer.lua',
        config = get_config('colorizer'),
    })

    use({
        'windwp/nvim-autopairs',
        config = get_config('autopairs'),
    })

    use({
        'christoomey/vim-tmux-navigator',
        config = get_config('vim-tmux-navigator'),
    })

    use({
        'akinsho/toggleterm.nvim',
        config = get_config('toggleterm'),
    })

    use({
        'folke/trouble.nvim',
        config = get_config('trouble'),
    })

    use({ 'chaoren/vim-wordmotion' })

    use({ 'github/copilot.vim' })
end
