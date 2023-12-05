local options = {
	autoindent = true,
	backup = true,
	backupdir = os.getenv("XDG_DATA_HOME") .. "/nvim/backup",
	breakindent = true,
	clipboard = "unnamedplus",
	cmdheight = 0,
	colorcolumn = "80",
	compatible = false,
	completeopt = { "menuone", "noinsert", "noselect" },
	confirm = true,
	copyindent = true,
	cursorline = true,
	errorbells = false,
	exrc = true,
	foldexpr = "nvim_treesitter#foldexpr()",
	foldlevelstart = 99, -- Start unfolded
	foldmethod = "expr",
	guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",
	hlsearch = false,
	ignorecase = true,
	inccommand = "split", -- Live substitution
	incsearch = true,
	laststatus = 3,
	linebreak = true,
	list = true,
	listchars = { tab = "┊ ", trail = "·", extends = ">" },
	mouse = "a",
	preserveindent = true,
	pumheight = 15, -- Completion
	scrolloff = 25,
	shiftwidth = 2,
	showmode = false,
	sidescrolloff = 8,
	signcolumn = "auto:2-5",
	showbreak = "↪",
	showmatch = true,
	smartcase = true,
	smartindent = true,
	softtabstop = 2,
	spell = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 2,
	termguicolors = true,
	timeout = true,
	timeoutlen = 300,
	undodir = os.getenv("XDG_DATA_HOME") .. "/nvim/undo-history",
	undofile = true,
	updatetime = 250,
	wildmenu = true,
	wildmode = { "longest", "list", "full" },
	wildoptions = "pum",
	wrap = true,
}

for name, value in pairs(options) do
	vim.opt[name] = value
end

local window_options = {
	number = true,
	relativenumber = true,
}

for name, value in pairs(window_options) do
	vim.wo[name] = value
end
