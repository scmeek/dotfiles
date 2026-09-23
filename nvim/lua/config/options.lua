local data_dir = vim.fn.stdpath("data")

local options = {
  autoindent = true,
  backup = true,
  backupdir = data_dir .. "/backup",
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
  foldlevelstart = 99, -- Start unfolded
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
  undodir = data_dir .. "/undo-history",
  wildmenu = true,
  wildmode = { "longest", "list", "full" },
  wildoptions = "pum",
  wrap = true,
}

-- Ensure the backup and undo directories exist.
vim.fn.mkdir(options.backupdir, "p")
vim.fn.mkdir(options.undodir, "p")

for name, value in pairs(options) do
  vim.opt[name] = value
end

local window_options = {
  relativenumber = false,
}

for name, value in pairs(window_options) do
  vim.wo[name] = value
end
