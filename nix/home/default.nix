{ ... }:

{
  # Shared Home Manager configuration for Linux and macOS.

  imports = [
    ./cli.nix
    ./git.nix
    ./shell.nix
    ./starship.nix
  ];
}
