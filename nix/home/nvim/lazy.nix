{ lib, pkgs, ... }:
{
  programs.neovim.plugins = [ pkgs.vimPlugins.lazy-nvim ];
  xdg.configFile."nvim/lua/config/lazy.lua".text = ''
    local enable_copilot = os.getenv("NVIM_ENABLE_COPILOT") == "1"

    require("lazy").setup({
      spec = {
        {
          "LazyVim/LazyVim",
          import = "lazyvim.plugins",
          init = function() require("config.highlights").setup() end,
        },
        { import = "extras" },
        { import = "lazyvim.plugins.extras.ai.copilot", enabled = enable_copilot },
        { import = "plugins" },
      },
      defaults = {
        lazy = true,
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
      },
      checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
      }, -- automatically check for plugin updates
      ui = {
        icons = {
          ft = "",
          lazy = "󰂠 ",
          loaded = "",
          not_loaded = "",
        },
      },
      performance = {
        rtp = {
          -- disable some rtp plugins
          disabled_plugins = {
            "gzip",
            -- "matchit",
            -- "matchparen",
            -- "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
    })

    -- Workarund until https://github.com/folke/lazy.nvim/pull/2182 is merged
    -- Skip helptags generation for read-only plugin directories (Nix store).
    local docs = require("lazy.manage.task.plugin").docs
    local original_skip = docs.skip

    docs.skip = function(plugin)
      local dir = plugin.dir .. "/doc"
      if vim.fn.isdirectory(dir) == 1 and not vim.uv.fs_access(dir, "W") then
        return true
      end
      return original_skip(plugin)
    end
  '';
  xdg.configFile."nvim/lua/extras/init.lua".text =
    "return "
    + lib.generators.toLua { } [
      { import = "lazyvim.plugins.extras.editor.dial"; }
      { import = "lazyvim.plugins.extras.editor.inc-rename"; }
      { import = "lazyvim.plugins.extras.lang.git"; }
      { import = "lazyvim.plugins.extras.lang.markdown"; }
      { import = "lazyvim.plugins.extras.util.dot"; }
      { import = "lazyvim.plugins.extras.util.mini-hipatterns"; }
    ];
}
