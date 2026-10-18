{ pkgs, ... }:

{
  imports = [ ./shell.nix ];

  home.packages = [
    pkgs.raycast
    pkgs.darwin.trash
  ];
}
