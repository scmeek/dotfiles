{ ... }:

{
  imports = [
    ../home
    ../profiles/development
  ];

  home = {
    username = "sean";
    homeDirectory = "/home/sean";
    stateVersion = "26.05";
    sessionVariables.NVIM_ENABLE_COPILOT = "1";
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;

  programs.zsh.shellAliases.hrs = "nix flake update && home-manager build --flake .#sean@ASUS-2D03N64 && home-manager switch --flake .#sean@ASUS-2D03N64";
}
