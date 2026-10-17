{ ... }:

{
  # Shared Home Manager configuration for Linux and macOS.

  imports = [
    ./cli.nix
    ./environment.nix
    ./git.nix
    ./shell.nix
    ./starship.nix
    ./tmux.nix
  ];
}
