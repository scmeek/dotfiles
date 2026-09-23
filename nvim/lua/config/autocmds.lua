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

local verbose_log_count = 0
user_command("ToggleVerboseLogging", function()
  if vim.opt.verbose:get() == 0 then
    local log_dir = "/tmp/nvim/logs"
    vim.fn.mkdir(log_dir, "p", "0700")
    verbose_log_count = verbose_log_count + 1
    local log_file = string.format(
      "%s/%s-%d-%d-verbose.log",
      log_dir,
      os.date("%Y-%m-%d_%H-%M-%S"),
      vim.fn.getpid(),
      verbose_log_count
    )
    vim.fn.writefile({}, log_file, "a")
    vim.opt.verbosefile = log_file
    vim.opt.verbose = 15
    print("Verbose logging enabled: " .. log_file)
  else
    local log_file = vim.opt.verbosefile:get()
    vim.opt.verbose = 0
    vim.opt.verbosefile = ""
    print("Verbose logging disabled: " .. log_file)
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
    vim.opt_local.spell = false
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
