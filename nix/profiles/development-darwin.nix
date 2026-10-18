{ pkgs, ... }:

{
  imports = [ ./development.nix ];

  home.packages = [
    (pkgs.callPackage ../packages/devlycli-darwin.nix { })
    pkgs.lima
  ];
}
