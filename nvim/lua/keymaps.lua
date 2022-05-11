vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>vr', ':source ~/.config/nvim/init.lua<cr>') -- Refresh
-- Edit configs
vim.keymap.set('n', '<leader>vi', ':edit ~/.config/nvim/init.lua<cr>') -- init.lua
vim.keymap.set('n', '<leader>vk', ':edit ~/.config/nvim/lua/keymaps.lua<cr>') -- keymaps.lua
vim.keymap.set('n', '<leader>vo', ':edit ~/.config/nvim/lua/options.lua<cr>') -- options.lua
vim.keymap.set('n', '<leader>vp', ':edit ~/.config/nvim/lua/plugins.lua<cr>') -- plugins.lua
vim.keymap.set('n', '<leader>vl', ':edit ~/.config/nvim/lua/plugin_configs/nvim-lspconfig.lua<cr>') -- nvim-lspconfig.lua

-- Save buffer
vim.keymap.set('', '<leader>s', ':w<CR>')

-- Select all
vim.keymap.set('n', '<leader>a', 'ggVG')

-- Easier split navigations
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- Easier splits handling
vim.keymap.set('n', '<leader>|', '<C-W>v', { silent = true })
vim.keymap.set('n', '<leader>-', '<C-W>s', { silent = true })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection
--  http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- Reselect pasted text
vim.keymap.set('n', 'gp', '`[v`]')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set('', 'j', function()
    return vim.v.count == 0 and 'gj' or 'j'
end, { silent = true, expr = true })
vim.keymap.set('', 'k', function()
    return vim.v.count == 0 and 'gk' or 'k'
end, { silent = true, expr = true })

-- Make Y behave like the other capitals
vim.keymap.set('n', 'Y', 'y$')

-- Move line up
vim.keymap.set('n', '<leader>k', ':m -2<CR>')
-- Move line down
vim.keymap.set('n', '<leader>j', ':m +1<CR>')

-- Diff with clipboard
--  https://www.reddit.com/r/neovim/comments/sg919r/diff_with_clipboard/huy72t0/?utm_source=reddit&utm_medium=web2x&context=3
vim.keymap.set('n', 'cp', function()
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
end)
