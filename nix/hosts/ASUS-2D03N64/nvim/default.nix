{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CARGO_NET_GIT_FETCH_WITH_CLI = "true";
    NVIM_ENABLE_COPILOT = "0";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };

  home.packages = with pkgs; [
    bacon
    chafa
    devcontainer
    docker-client
    ghostscript
    mermaid-cli
    rustup
    texliveSmall
    ueberzugpp
    viu
  ];

  programs.neovim.extraPackages = with pkgs; [
    bacon
    black
    clang-tools
    devcontainer
    docker-client
    isort
    pyright
    python3Packages.debugpy
    prettier
    rustup
    taplo
    typescript-language-server
    yaml-language-server
    yamlfmt
    yamllint
  ];

  xdg.configFile = {
    "nvim/lua/config/atlas.lua".source = ../../../profiles/development/nvim/plugins/atlas.lua;
    "nvim/lua/plugins/atlas.lua".source = lib.mkForce ./plugins/atlas.lua;
    "nvim/lua/config/obsidian.lua".source = ../../../profiles/notes/nvim/plugins/obsidian.lua;
    "nvim/lua/plugins/obsidian.lua".source = ./plugins/obsidian.lua;
    "nvim/lua/config/smear_cursor.lua".source = ../../../home/nvim/plugins/smear_cursor.lua;
    "nvim/lua/plugins/smear_cursor.lua".source = lib.mkForce ./plugins/smear_cursor.lua;
  };
}
