{ pkgs, ... }:

{
  programs = {
    bat.enable = true;

    eza = {
      enable = true;
      enableZshIntegration = false;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    ripgrep.enable = true;

    yazi = {
      enable = true;
      enableZshIntegration = false;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    arp-scan
    bash
    bind
    coreutils
    duf
    fastfetch
    ffmpeg
    hexyl
    imagemagick
    librsvg
    lnav
    lolcat
    nixfmt
    nnn
    p7zip
    poppler-utils
    rsync
    slides
    typtea
    unbound
    wget
    zbar
  ];
}
