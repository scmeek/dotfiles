{ pkgs, ... }:

{
  home.packages = [ pkgs.gnupg ];

  programs.git.settings.commit.gpgsign = true;

  programs.zsh.initContent = ''
    if [[ -t 1 ]]; then
      export GPG_TTY="$(tty)"
    fi
  '';
}
