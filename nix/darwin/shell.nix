{ ... }:

{
  programs.zsh.initContent = ''
    # Prefer Nix-managed tools over Homebrew.
    path=(
      /etc/profiles/per-user/sean/bin
      ''${path:#/etc/profiles/per-user/sean/bin}
    )
    typeset -U path PATH
  '';
}
