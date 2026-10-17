{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" = {
    source = ../../nvim;
    recursive = true;
  };


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

