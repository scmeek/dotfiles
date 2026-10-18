{ ... }:

{
  programs.zsh = {
    initContent = ''
      # Prefer Nix-managed tools over Homebrew.
      path=(
        /etc/profiles/per-user/sean/bin
        ''${path:#/etc/profiles/per-user/sean/bin}
      )
      typeset -U path PATH
    '';

    shellAliases = {
      drs = "darwin-rebuild build --flake .#S-MBA && sudo darwin-rebuild switch --flake .#S-MBA";
    };
  };
}
