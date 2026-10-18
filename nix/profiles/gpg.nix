{ config, pkgs, ... }:

{
  home.packages = [ pkgs.gnupg ];
  home.sessionVariables.GNUPGHOME = "${config.xdg.dataHome}/gnupg";

  programs.git.settings.commit.gpgsign = true;

  programs.zsh.initContent = ''
    if [[ -t 1 ]]; then
      export GPG_TTY="$(tty)"
    fi
  '';
}
