{ ... }:

{
  imports = [ ../home ];

  programs.zsh.shellAliases.nrs = "nfmt && nix flake update && nix flake check && nixos-rebuild build --flake .#rigel && sudo nixos-rebuild switch --flake .#rigel B";
}
