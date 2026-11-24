{ pkgs, ... }:

{
  imports = [ ./nvim ];

  home.packages = [ pkgs.obsidian ];
}
