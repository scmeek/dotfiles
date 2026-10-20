{ lib, pkgs, ... }:

{
  programs.neovim.extraPackages = [
    pkgs.tree-sitter
  ]
  ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.gcc;
}
