vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

if os.getenv("NVIM_ENABLE_COPILOT") == "1" then
  vim.notify("GitHub Copilot enabled", nil, { id = "github_copilot", style = "minimal" })
end
