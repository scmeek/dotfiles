local enable_copilot = os.getenv("NVIM_ENABLE_COPILOT") == "1"

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      init = function()
        require("config.highlights").setup()
      end,
    },
    { import = "extras" },
    {
      import = "lazyvim.plugins.extras.ai.copilot",
      enabled = enable_copilot,
    },
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },
  checker = {
    enabled = true,
    notify = false,
  },
  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Workaround until https://github.com/folke/lazy.nvim/pull/2182 is merged:
-- skip helptags generation for read-only plugin directories (Nix store).
local docs = require("lazy.manage.task.plugin").docs
local original_skip = docs.skip

docs.skip = function(plugin)
  local dir = plugin.dir .. "/doc"
  if vim.fn.isdirectory(dir) == 1 and not vim.uv.fs_access(dir, "W") then
    return true
  end
  return original_skip(plugin)
end
