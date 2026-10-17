{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    actionlint
    gh
    go
    gnumake
    gcc
    just
    opencode
    pandoc
    pkg-config
    pyenv
    rustup
    zig
    zola

    # Runtimes
    nodejs_24
    python315
    luarocks

    # Containers
    devcontainer
    docker-client
    docker-compose
    lazydocker

    # Neovim dependencies
    fd
    viu
    chafa
    ueberzugpp
    ghostscript
    mermaid-cli

    # LaTeX
    texliveSmall
  ];
}
