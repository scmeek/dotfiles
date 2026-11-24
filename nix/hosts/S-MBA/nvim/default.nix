{ lib, ... }:

{
  home.sessionVariables.NVIM_ENABLE_COPILOT = "1";

  # Host specs require the profile spec from lua/config and modify it.
  xdg.configFile = {
    "nvim/lua/config/obsidian.lua".source = ../../../profiles/notes/nvim/lua/plugins/obsidian.lua;
    "nvim/lua/plugins/obsidian.lua".source = lib.mkForce ./plugins/obsidian.lua;
  };
}
