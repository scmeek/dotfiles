{ pkgs, ... }:

{
  imports = [
    ./halloy.nix
    ./shell.nix
  ];

  home.packages = [
    pkgs.raycast
    pkgs.darwin.trash
  ];
}
