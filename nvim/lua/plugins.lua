vim.api.nvim_command('packadd packer.nvim')

-- Get `require` statement for corresponding config file
function get_config(name)
    return string.format('require("plugin-config/%s")', name)
end

return require('packer').startup({
    function(use)
        use('wbthomason/packer.nvim') -- Manage itself

        use('bluz71/vim-nightfly-guicolors')

        -- Language server protocol
        use({
            'neovim/nvim-lspconfig',
            config = get_config('nvim-lspconfig'),
            requires = {
                'hrsh7th/nvim-cmp', -- Autocompletion plugin
                'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
                'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
                'L3MON4D3/LuaSnip', -- Snippets plugin
            },
        })

        -- tree-sitter
        use({
            {
                'nvim-treesitter/nvim-treesitter',
                config = get_config('nvim-treesitter'),
                run = ':TSUpdate',
            },
            -- Used by:
            {
                {
                    'lewis6991/nvim-treesitter-context',
                    config = get_config('nvim-treesitter-context'),
                },
                'nvim-treesitter/nvim-treesitter-refactor',
            },
        })

        use({
            'mhartington/formatter.nvim',
            config = get_config('formatter'),
        })

        use({
            'nvim-telescope/telescope.nvim',
            config = get_config('telescope'),
            requires = {
                'nvim-lua/plenary.nvim',
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            },
        })

        -- File explorer
        use({
            'kyazdani42/nvim-tree.lua',
            config = get_config('nvim-tree'),
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        })

        -- Buffers git integration
        use({
            'lewis6991/gitsigns.nvim',
            config = get_config('gitsigns'),
        })

        -- Status line
        use({
            'nvim-lualine/lualine.nvim',
            config = get_config('lualine'),
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        })

        -- Tabline
        use({
            'romgrk/barbar.nvim',
            config = get_config('barbar'),
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        })

        use({
            'folke/which-key.nvim',
            config = get_config('which-key'),
        })

        -- Documentation generator
        use({
            'kkoomen/vim-doge',
            config = get_config('doge'),
        })

        use('tpope/vim-commentary')
        use('christoomey/vim-tmux-navigator')
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        },
        profile = {
            enable = true,
            threshold = 1, -- Time in ms minimum to show in profile
        },
    },
})
