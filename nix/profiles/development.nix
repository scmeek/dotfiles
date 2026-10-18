{ config, pkgs, ... }:

{
  home.sessionVariables = {
    AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_PREFIX = "${config.xdg.dataHome}/npm";
    PSQL_HISTORY = "${config.xdg.dataHome}/psql_history";
    PYENV_ROOT = "${config.xdg.dataHome}/pyenv";
    PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };

  programs.zsh.shellAliases.p = "python3";

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
