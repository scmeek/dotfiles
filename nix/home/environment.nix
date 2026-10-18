{ config, ... }:

let
  xdg = config.xdg;
  home = config.home.homeDirectory;
in
{
  xdg.enable = true;

  home.sessionVariables = {
    LESSHISTFILE = "${xdg.stateHome}/less/history";

    SM_XDG_BIN_HOME = "${home}/.local/bin";
    SM_XDG_BIN_BIN_HOME = "${home}/.local/bin/bin";
  };

  home.sessionPath = [
    "${home}/.local/bin"
    "${home}/.local/bin/bin"
  ];

  # Yazi configuration
  xdg.configFile."yazi" = {
    source = ../../yazi;
    recursive = true;
  };
}
