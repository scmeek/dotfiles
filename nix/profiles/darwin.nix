{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.callPackage ../packages/devlycli.nix { })

    raycast

    # Terminal utilities
    bash
    coreutils
    duf
    fastfetch
    hexyl
    imagemagick
    lnav
    nnn
    lolcat
    p7zip
    poppler-utils
    rsync
    slides
    darwin.trash
    typtea
    zbar

    # Virtualization
    lima

    # Networking and DNS
    arp-scan
    bind
    unbound

    # Media utilities
    ffmpeg
    librsvg
  ];

  programs.git.settings = {
    user.signingkey = "8F73E7B76CBD3188";
    commit.gpgsign = true;
  };
}
