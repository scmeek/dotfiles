{ config, ... }:

{
  programs.zsh = {
    shellAliases = {
      doawake = "caffeinate -dimsu &";
      drs = "nfmt && nix flake update && nix flake check && darwin-rebuild build --flake .#S-MBA && sudo darwin-rebuild switch --flake .#S-MBA B";
    };

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
