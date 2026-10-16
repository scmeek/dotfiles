{ pkgs, ... }:

{
  programs = {
    bat.enable = true;

    eza = {
      enable = true;
      enableZshIntegration = false;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    ripgrep.enable = true;

    yazi = {
      enable = true;
      enableZshIntegration = false;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    lazygit
    wget
  ];
}
