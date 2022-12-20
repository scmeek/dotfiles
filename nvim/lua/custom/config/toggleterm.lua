require('toggleterm').setup({
    size = 60,
    open_mapping = [[<leader>t]],
    hide_numbers = true,
    autochdir = false,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    persist_mode = true,
    direction = 'vertical',
    close_on_exit = true,
    auto_scroll = true,
    winbar = {
        enabled = true,
        name_formatter = function(term)
            return term.name
        end,
    },
})
