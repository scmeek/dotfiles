{
  config,
  lib,
  opencode-nixpkgs,
  pkgs,
  ...
}:

{
  imports = [ ./nvim ];

  # Disable every provider, including free models, until explicitly enabled.
  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    enabled_providers = [ ];
  };

  home.sessionVariables = {
    AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_PREFIX = "${config.xdg.dataHome}/npm";
    PSQL_HISTORY = "${config.xdg.dataHome}/psql_history";
    PYENV_ROOT = "${config.xdg.dataHome}/pyenv";
  };

  home.sessionPath = [ "${config.home.sessionVariables.NPM_CONFIG_PREFIX}/bin" ];

  home.packages = with pkgs; [
    actionlint
    deno
    docker-client
    docker-compose
    gh
    go
    gnumake
    just
    lazydocker
    luarocks
    opencode-nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode
    pandoc
    pkg-config
    pyenv
    zig
    zola
  ];
}
