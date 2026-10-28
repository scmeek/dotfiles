{
  lib,
  pkgs,
  db9s,
  wtfi2,
  ...
}:

{
  home.packages =
    with pkgs;
    [
      arp-scan
      bash
      bind
      coreutils
      curl
      (pkgs.callPackage ../packages/db9s.nix { src = db9s; })
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
      unzip
      wget
      yt-dlp
      zbar
      wtfi2.packages.${pkgs.stdenv.hostPlatform.system}.default
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
