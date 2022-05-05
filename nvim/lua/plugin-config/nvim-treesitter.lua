require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'lua',
        'python',
    },

    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = false,
        },
        highlight_current_scope = { enable = false },
    },
})
