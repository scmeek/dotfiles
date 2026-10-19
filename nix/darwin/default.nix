{ pkgs, ... }:

{
  imports = [
    ./halloy.nix
    ./keybindings.nix
    ./shell.nix
    ./shortcuts.nix
    ./yazi.nix
  ];

  home.packages = [
    pkgs.raycast
    pkgs.darwin.trash
  ];
}
