local autocmd = vim.api.nvim_create_autocmd
local user_command = vim.api.nvim_create_user_command

user_command("WQ", "wq", {})
user_command("Wq", "wq", {})
user_command("W", "w", {})
user_command("Qa", "qa", {})
user_command("Q", "q", {})

autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("Highlight on yank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

user_command("ToggleVerboseLogging", function()
  if vim.opt.verbose:get() == 0 then
    print("Enabling verbose logging")
    vim.opt.verbosefile = vim.fn.expand("~/log/vim/verbose.log")
    vim.opt.verbose = 15
  else
    print("Disabling verbose logging")
    vim.opt.verbose = 0
    vim.opt.verbosefile = nil
  end
end, {})

autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Disable spell", { clear = true }),
  pattern = {
    "gitignore",
    "lspinfo",
    "noice",
    "nvcheatsheet",
    "nvdash",
    "NvimTree",
    "TelescopePrompt",
    "TelescopeResults",
    "terminal",
    "WhichKey",
  },
  callback = function()
    vim.opt.spell = false
  end,
})

-- Restore cursor position on file open
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if
      line > 1
      and line <= vim.fn.line("$")
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd('normal! g`"')
    end
  end,
})
