{ lib, ... }:

{
  home.sessionVariables.NVIM_ENABLE_COPILOT = "0";

  xdg.configFile = {
    "nvim/lua/config/atlas.lua".source = ../../../profiles/development/nvim/plugins/atlas.lua;
    "nvim/lua/plugins/atlas.lua".source = lib.mkForce ./plugins/atlas.lua;
    "nvim/lua/config/obsidian.lua".source = ../../../profiles/notes/nvim/plugins/obsidian.lua;
    "nvim/lua/plugins/obsidian.lua".source = lib.mkForce ./plugins/obsidian.lua;
    "nvim/lua/config/smear_cursor.lua".source = ../../../home/nvim/plugins/smear_cursor.lua;
    "nvim/lua/plugins/smear_cursor.lua".source = lib.mkForce ./plugins/smear_cursor.lua;
  };
}
