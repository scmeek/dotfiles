{
  config,
  lib,
  pkgs,
  ...
}:

let
  opencodeProviders = config.dotfiles.opencode.providers;
in
{
  imports = [ ./nvim ];

  options.dotfiles.opencode.providers = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "OpenCode providers this host may use; all others are denied.";
  };

  config = {
    programs.opencode = {
      enable = true;
      # Hosts opt in to providers; credentials stay in OpenCode's local state.
      settings = {
        policies = [
          {
            action = "provider.use";
            resource = "*";
            effect = "deny";
          }
        ]
        ++ map (provider: {
          action = "provider.use";
          resource = provider;
          effect = "allow";
        }) opencodeProviders;

        plugins = lib.optionals (lib.elem "anthropic" opencodeProviders) [
          "opencode-claude-auth@latest"
        ];
      };
    };

    programs.zsh.shellAliases.oc = "opencode";

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
      pandoc
      pkg-config
      pyenv
      zig
      zola
    ];
  };
}
