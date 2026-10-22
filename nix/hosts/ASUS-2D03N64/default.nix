{
  lib,
  pkgs,
  self,
  ...
}:

{
  imports = [
    ../../home
    ./git.nix
    ./shell.nix
    ../../profiles/development
    ../../profiles/notes/nvim
    ./nvim
  ];

  home = {
    username = "sean";
    homeDirectory = "/home/sean";
    stateVersion = "26.05";
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    pixi
  ];

  # symlink home-manager to /nix/store/...-source for config file
  xdg.configFile."home-manager".source = self;
}
