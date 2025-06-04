local options = {
  autoindent = true,
  backup = true,
  backupdir = os.getenv("XDG_DATA_HOME") .. "/nvim/backup",
  breakindent = true,
  cmdheight = 0,
  colorcolumn = "80",
  compatible = false,
  completeopt = { "menuone", "noinsert", "noselect" },
  conceallevel = 1,
  confirm = true,
  copyindent = true,
  errorbells = false,
  exrc = true,
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevelstart = 99, -- Start unfolded
  foldmethod = "expr",
  grepprg = "rg --vimgrep --no-heading --smart-case --hidden",
  grepformat = "%f:%l:%c:%m",
  hlsearch = false,
  inccommand = "split", -- Live substitution
  incsearch = true,
  laststatus = 3,
  linebreak = true,
  list = true,
  listchars = { tab = "┊ ", trail = "·", extends = ">" },
  preserveindent = true,
  pumheight = 15, -- Completion
  scrolloff = 25,
  sidescrolloff = 8,
  showbreak = "↪",
  showmatch = true,
  spell = true,
  splitkeep = "screen",
  swapfile = false,
  timeout = true,
  undodir = os.getenv("XDG_DATA_HOME") .. "/nvim/undo-history",
  wildmenu = true,
  wildmode = { "longest", "list", "full" },
  wildoptions = "pum",
  wrap = true,
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

local window_options = {
  -- relativenumber = true,
}

for name, value in pairs(window_options) do
  vim.wo[name] = value
end
