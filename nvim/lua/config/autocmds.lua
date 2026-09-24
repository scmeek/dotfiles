local autocmd = vim.api.nvim_create_autocmd
local user_command = vim.api.nvim_create_user_command

user_command("WQ", "wq", {})
user_command("Wq", "wq", {})
user_command("W", "w", {})
user_command("Qa", "qa", {})
user_command("Q", "q", {})

-- LazyVim supplies yank highlighting. Lastplace owns cursor restoration so its
-- exclusions and fold-opening behavior are not bypassed by LazyVim's callback.
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_last_loc")

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
