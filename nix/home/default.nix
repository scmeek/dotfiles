{ ... }:

{
  # Shared Home Manager configuration for Linux and macOS.

  imports = [
    ./git.nix
    ./starship.nix
  ];
}

