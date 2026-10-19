{ pkgs, ... }:

{
  imports = [ ./development ];

  home.packages = [
    (pkgs.callPackage ../packages/devlycli-darwin.nix { })
    pkgs.lima
  ];
}
