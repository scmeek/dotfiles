-- Already in init.lua
--vim.g.mapleader = ' '
--vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>f', 'ggVG', { desc = 'Select all text in [F]ile' })
vim.keymap.set('n', '<leader>mk', ':m -2<CR>', { desc = '[M]ove line [K] up' })
vim.keymap.set('n', '<leader>mj', ':m +1<CR>', { desc = '[M]ove line [J] down' })
vim.keymap.set('n', 'Y', 'y$', { desc = '[Y] rest of line' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection
--  http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

vim.keymap.set('n', 'gp', '`[v`]', { desc = '[G]o reselect [P]asted text' })

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('', 'j', function()
    return vim.v.count == 0 and 'gj' or 'j'
end, { silent = true, expr = true })
vim.keymap.set('', 'k', function()
    return vim.v.count == 0 and 'gk' or 'k'
end, { silent = true, expr = true })

--  https://www.reddit.com/r/neovim/comments/sg919r/diff_with_clipboard/huy72t0/?utm_source=reddit&utm_medium=web2x&context=3
vim.keymap.set('n', 'cb', function()
    local ftype = vim.api.nvim_eval('&filetype')
    vim.cmd(string.format(
        [[
    	    vsplit
    	    enew
    	    normal! P
    	    setlocal buftype=nowrite
    	    set filetype=%s
    	    diffthis
    	    bprevious
    	    execute "normal! \<C-w>\<C-w>"
    	    diffthis
  	    ]],
        ftype
    ))
end, { desc = 'Diff with [C]lip[B]oard' })
