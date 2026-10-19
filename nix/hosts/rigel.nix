{ ... }:

{
  imports = [ ../home ];

  programs.zsh.shellAliases.nrs = "nix flake update && nixos-rebuild build --flake .#rigel && sudo nixos-rebuild switch --flake .#rigel";
}
