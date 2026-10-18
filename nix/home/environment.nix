{ config, ... }:

let
  xdg = config.xdg;
  home = config.home.homeDirectory;
in
{
  xdg.enable = true;

  home.sessionVariables = {
    AWS_SHARED_CREDENTIALS_FILE = "${xdg.configHome}/aws/credentials";
    AWS_CONFIG_FILE = "${xdg.configHome}/aws/config";

    CARGO_HOME = "${xdg.dataHome}/cargo";
    DOCKER_CONFIG = "${xdg.configHome}/docker";
    GRADLE_USER_HOME = "${xdg.dataHome}/gradle";

    LESSHISTFILE = "${xdg.stateHome}/less/history";

    NODE_REPL_HISTORY = "${xdg.dataHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${xdg.configHome}/npm/npmrc";

    PSQL_HISTORY = "${xdg.dataHome}/psql_history";
    PYENV_ROOT = "${xdg.dataHome}/pyenv";
    PYTHONSTARTUP = "${xdg.configHome}/python/pythonrc";

    RIPGREP_CONFIG_PATH = "${xdg.configHome}/ripgrep/ripgreprc";

    RUSTUP_HOME = "${xdg.dataHome}/rustup";

    SM_XDG_BIN_HOME = "${home}/.local/bin";
    SM_XDG_BIN_BIN_HOME = "${home}/.local/bin/bin";

    STARSHIP_CACHE = "${xdg.dataHome}/starship/cache";
  };

  home.sessionPath = [
    "${home}/.local/bin"
    "${home}/.local/bin/bin"
  ];

  # Bat configuration
  xdg.configFile."bat/config".source = ../../batconfig;

  # Ripgrep configuration
  xdg.configFile."ripgrep/ripgreprc".source = ../../ripgreprc;

  # Yazi configuration
  xdg.configFile."yazi" = {
    source = ../../yazi;
    recursive = true;
  };
}
