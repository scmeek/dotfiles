{ lib, pkgs, ... }:

{
  programs.neovim.extraPackages = with pkgs; [
    gcc
    tree-sitter
  ];
}
