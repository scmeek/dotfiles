{ lib, pkgs, ... }:

{
  # Lets Ghostty sessions that SSH into this machine use xterm-ghostty.
  home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [ pkgs.ghostty.terminfo ];
}
