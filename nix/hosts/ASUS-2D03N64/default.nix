{ lib, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ../../home
    ../../profiles/development
  ];

  home = {
    username = "sean";
    homeDirectory = "/home/sean";
    stateVersion = "26.05";
    sessionVariables.NVIM_ENABLE_COPILOT = "0";
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;

  programs.zsh.shellAliases.hrs = "nix flake update && home-manager build --flake .#sean@ASUS-2D03N64 && home-manager switch --flake .#sean@ASUS-2D03N64";

  xdg.configFile = {
    "nvim/lua/config/atlas.lua".source = ../../profiles/development/nvim/atlas.lua;
    "nvim/lua/plugins/atlas.lua".source = lib.mkForce ./atlas.lua;
    "nvim/lua/config/obsidian.lua".source = ../../profiles/notes/nvim/obsidian.lua;
    "nvim/lua/plugins/obsidian.lua".source = ./obsidian.lua;
    "nvim/lua/config/smear_cursor.lua".source = ../../home/nvim/plugins/smear_cursor.lua;
    "nvim/lua/plugins/smear_cursor.lua".source = lib.mkForce ./smear_cursor.lua;
  };
}
