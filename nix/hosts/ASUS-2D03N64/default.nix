{ lib, pkgs, ... }:

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

  programs.zsh.shellAliases.hrs = "nix flake update && home-manager build --flake .#sean@ASUS-2D03N64 && home-manager switch --flake .#sean@ASUS-2D03N64";
}
