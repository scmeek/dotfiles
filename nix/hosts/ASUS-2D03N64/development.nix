{ pkgs, ... }:

{
  imports = [
    ../../profiles/development
  ];

  home.packages = with pkgs; [
    pixi
  ];
}
