return {
    'akinsho/toggleterm.nvim',
    config = function()
        require('toggleterm').setup({
            size = function(term)
                if term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-s>]],
            hide_numbers = true,
            direction = 'vertical',
            close_on_exit = true,
        })

        -- pane switching
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        end

        vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
    end,
}
