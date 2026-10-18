{ ... }:

{
  imports = [ ./homebrew.nix ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  programs.zsh.enable = true;
  nix-homebrew.enable = true;
}
