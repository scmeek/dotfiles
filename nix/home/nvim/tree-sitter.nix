{ pkgs, ... }: { programs.neovim.extraPackages = [ pkgs.tree-sitter ]; }
