{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    gh
    rustup
    gcc
    gnumake
    pkg-config
    nodejs
    devcontainer

    # Neovim dependencies
    fd
    viu
    chafa
    ueberzugpp
    luarocks
    ghostscript
    mermaid-cli

    # LaTeX
    texliveSmall
  ];
}
