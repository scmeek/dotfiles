-- pane switching
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
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
            cmd = 'lazygit',
            dir = 'git_dir',
            direction = 'float',
            float_opts = {
                border = 'curved',
            },
            hidden = true,
            on_open = function(term)
                vim.cmd('startinsert!')
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<Cmd>close<CR>', {
                    noremap = true,
                    silent = true,
                })
                vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', {
                    noremap = true,
                    silent = true,
                })
            end,
            on_close = function(term)
                vim.cmd('startinsert!')
            end,
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.keymap.set('n', '<leader>g', '<Cmd>lua _lazygit_toggle()<CR>', { desc = 'lazy[G]it' })
    end,
}
