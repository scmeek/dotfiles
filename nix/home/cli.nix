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
      (callPackage ../packages/db9s.nix { src = db9s; })
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
      wtfi2.packages.${stdenv.hostPlatform.system}.default
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [
      espeak-ng
      libnotify
      pandoc
      util-linux
      wl-clipboard
      xclip
    ];
}
