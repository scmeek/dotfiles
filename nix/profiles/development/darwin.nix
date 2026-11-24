{ pkgs, ... }:

{
  imports = [ ./. ];

  home.packages = [
    (pkgs.callPackage ../../packages/devlycli.nix { })
    pkgs.lima
  ];
}
