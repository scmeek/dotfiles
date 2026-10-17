
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development
    gh
    go
    nodejs
    python3
    pyenv
    zig
    pandoc

    # Terminal utilities
    bash
    coreutils
    duf
    fastfetch
    hexyl
    imagemagick
    lazydocker
    lnav
    poppler
    rsync
    p7zip
    zbar
    zola

    # GPG
    gnupg
  ];

  programs.git.settings = {
    user.signingkey = "8F73E7B76CBD3188";
    commit.gpgsign = true;
  };
}

