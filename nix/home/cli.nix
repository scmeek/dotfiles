{ lib, pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      arp-scan
      bash
      bind
      coreutils
      duf
      fastfetch
      fd
      ffmpeg
      gnused
      hexyl
      imagemagick
      jq
      librsvg
      lnav
      lolcat
      lsof
      ncurses
      nixfmt
      nnn
      nodejs
      p7zip
      perl
      poppler-utils
      python3
      rsync
      ruby
      slides
      typtea
      unbound
      wget
      yt-dlp
      zbar
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.espeak-ng
      pkgs.libnotify
      pkgs.pandoc
      pkgs.util-linux
      pkgs.wl-clipboard
      pkgs.xclip
    ];
}
