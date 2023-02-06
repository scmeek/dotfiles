--               O@@@@o.°#@@#   .@@@@@@@@@@@.       °@@@@@@#
--              #@@@@o    @@@  *@@°  o@@@@@@@      *@@@@@@@
--              @@@@@@.  o@@#  @@     *@@@@@@@    o@@@@@@@@
--              @@@@@@@#      #@*     @@@@@@@@o  #@@@@@@@@.
--              @@@@@@@@@*    @@@.    @#@@@@@@@ @@o@@@@@@@
--               @@@@@@@@@#   *@@@@* @@ o@@@@@@@@ O@@@@@@°
--                *@@@@@@@@*   o@@*  @@  @@@@@@@  @@@@@@@
--        .@@@O     @@@@@@@@        @@*  @@@@@@  O@@@@@@o  #
--        @@@@o      @@@@@@@       #@@   #@@@@   @@@@@@@  @@
--       O@@@@       .@@@@@°*#   *@@@    *@@@    @@@@@@@ @@
--       °@@@@       O@@@@@ @@@@@@@@°     @@     o@@@@@@@@.
--        #@@@*     *@@@@O   @@@@@@.      #       *@@@@@o
--         °@@@@@#@@@@@o       °°
--            °o##Oo.
--
--      Personal vim configuration of Sean Meek <sean@seanmeek.com>

----------------------------------------------------------------------------
-- General
----------------------------------------------------------------------------

vim.cmd[[colorscheme nord]]

-- :h <option> for details
-- :options lists all

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.autoindent = true

vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.exrc = true
vim.opt.hlsearch = false
vim.opt.errorbells = false
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undo-history'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = '80'
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.spell = true
vim.opt.signcolumn = 'auto'
vim.opt.showmode = false
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.wildmenu = true
vim.opt.inccommand = 'split' -- Live substitution
vim.opt.showbreak = '↪'
vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '·' }
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.confirm = true
vim.opt.backup = true
vim.opt.backupdir = os.getenv('HOME') .. '/.vim/backup'
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.timeoutlen = 500
vim.opt.updatetime = 50

vim.opt.termguicolors = true

-- More natural split opening
vim.opt.splitbelow = true
vim.opt.splitright = true

----------------------------------------------------------------------------
-- Keymaps
----------------------------------------------------------------------------

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

----------------------------------------------------------------------------
-- Miscellaneous
----------------------------------------------------------------------------

vim.g.custom_filetree_offset = 50

----------------------------------------------------------------------------
-- Autogroups
----------------------------------------------------------------------------

local local_group = vim.api.nvim_create_augroup('Local', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Temporarily highlight text on yank',
    group = local_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch' })
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Trim whitespace on save',
    group = local_group,
    pattern = '*',
    command = ':%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd('VimLeave', {
    desc = 'Set cursor to blinking horizontal when leaving neovim',
    group = local_group,
    pattern = '*',
    command = 'set guicursor=a:hor25-blinkon10',
})
