{ config, ... }:

let
  xdg = config.xdg;
  home = config.home.homeDirectory;
in
{
  xdg.enable = true;

  home.sessionVariables = {
    LESSHISTFILE = "${xdg.stateHome}/less/history";

    RIPGREP_CONFIG_PATH = "${xdg.configHome}/ripgrep/ripgreprc";

    SM_XDG_BIN_HOME = "${home}/.local/bin";
    SM_XDG_BIN_BIN_HOME = "${home}/.local/bin/bin";

    STARSHIP_CACHE = "${xdg.dataHome}/starship/cache";
  };

  home.sessionPath = [
    "${home}/.local/bin"
    "${home}/.local/bin/bin"
  ];

  # Ripgrep configuration
  xdg.configFile."ripgrep/ripgreprc".source = ../../ripgreprc;

  # Yazi configuration
  xdg.configFile."yazi" = {
    source = ../../yazi;
    recursive = true;
  };
}
