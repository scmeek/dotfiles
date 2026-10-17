{ pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.primaryUser = "sean";

  users.users.sean.home = "/Users/sean";

  system.stateVersion = 6;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.sean = {
      home.username = "sean";
      home.homeDirectory = "/Users/sean";
      home.stateVersion = "26.05";

      imports = [
        ../home/cli.nix
        ../home/environment.nix
        ../home/git.nix
        ./git.nix
        ../home/shell.nix
        ../home/starship.nix
      ];

      programs.zsh.initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };

  programs.zsh.enable = true;

  nix-homebrew = {
    enable = true;
    user = "sean";
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "none";
      autoUpdate = false;
      upgrade = false;
    };

    casks = [];
  };
}
