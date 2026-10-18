{ pkgs, ... }:

{
  imports = [
    ./halloy.nix
    ./shell.nix
    ./yazi.nix
  ];

  home.packages = [
    pkgs.raycast
    pkgs.darwin.trash
  ];
}
