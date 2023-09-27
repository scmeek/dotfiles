-- pane switching
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')


return {
    'akinsho/toggleterm.nvim',
    config = function()
        require('toggleterm').setup({
            size = function(term)
                if term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-s>]],
            hide_numbers = true,
            direction = 'vertical',
            close_on_exit = true,
        })

        -- lazygit
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit  = Terminal:new({
            cmd = 'lazygit --use-config-file="$HOME/.config/lazygit/config.yml"',
            dir = 'git_dir',
            direction = 'float',
            float_opts = {
                border = 'curved',
            },
            hidden = true,
            on_open = function(term)
                vim.cmd('startinsert!')
                vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', {
                    noremap = true,
                    silent = true,
                })
            end,
            on_close = function(term)
                vim.cmd('startinsert!')
            end,
        })

        function _LAZYGIT_TOGGLE()
            lazygit:toggle()
        end

        vim.keymap.set('n', '<leader>gl', '<Cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = '[L]azy[g]it' })
    end,
}
