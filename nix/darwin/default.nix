{ pkgs, ... }:

{
  imports = [
    ./homebrew.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

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
        ../home/nvim.nix
        ../home/shell.nix
        ../darwin/shell.nix
        ../home/starship.nix
        ../home/tmux.nix

        ../features/notes.nix

        ../profiles/darwin.nix
        ../profiles/development.nix
        ../profiles/gpg-darwin.nix
      ];
    };
  };

  programs.zsh.enable = true;

  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    fira-mono
    hack
    iosevka
    sauce-code-pro
    terminess-ttf
    victor-mono
  ];

  nix-homebrew = {
    enable = true;
    user = "sean";
    autoMigrate = true;
  };
}
