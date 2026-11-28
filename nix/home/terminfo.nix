{ lib, pkgs, ... }:

{
  # Lets Ghostty sessions that SSH into this machine use xterm-ghostty.
  # Low priority: ncurses >= 6.6 also ships share/terminfo/g/ghostty.
  home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [ (lib.lowPrio pkgs.ghostty.terminfo) ];
}
