{ config, ... }:

{
  programs.zsh = {
    shellAliases.doawake = "caffeinate -dimsu &";

    initContent = ''
      # Prefer Nix-managed tools over Homebrew.
      path=(
        /etc/profiles/per-user/${config.home.username}/bin
        ''${path:#/etc/profiles/per-user/${config.home.username}/bin}
      )
      typeset -U path PATH
    '';
  };
}
