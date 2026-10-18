{ pkgs, ... }:

{
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = false;
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
    gnused
    hexyl
    imagemagick
    librsvg
    lnav
    lolcat
    lsof
    ncurses
    nixfmt
    nnn
    p7zip
    perl
    poppler-utils
    rsync
    ruby
    slides
    typtea
    unbound
    wget
    yt-dlp
    zbar
  ];
}
