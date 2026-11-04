{ ... }:

{
  imports = [
    ./defaults.nix
    ./homebrew.nix
    ./shortcuts
    ./wezterm.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    interval = {
      Hour = 3;
      Minute = 15;
    };
    options = "--delete-older-than 10d";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  programs.zsh.enable = true;
  nix-homebrew.enable = true;
}
