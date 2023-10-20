-- :h <option> for details
-- :options lists all

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.exrc = true
vim.opt.hlsearch = false
vim.opt.errorbells = false
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.backupdir = os.getenv('XDG_DATA_HOME') .. '/nvim/backup'
vim.opt.undodir = os.getenv('XDG_DATA_HOME') .. '/nvim/undo-history'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.scrolloff = 25
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = '80'
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.spell = true
vim.opt.signcolumn = 'auto:2-5'
vim.opt.showmode = false
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.wildmenu = true
vim.opt.wildoptions = 'pum'
vim.opt.pumheight = 15;      -- Completion
vim.opt.inccommand = 'split' -- Live substitution
vim.opt.showbreak = '↪'
vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '·', extends = '>', }
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.confirm = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99 -- start unfolded

vim.opt.termguicolors = true

-- More natural split opening
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.wo.number = true
