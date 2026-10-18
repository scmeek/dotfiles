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
