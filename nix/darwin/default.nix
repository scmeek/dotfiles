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

  system = {
    stateVersion = 6;
    primaryUser = "sean";

    activationScripts.postActivation.text = ''
      # Fix sudoers permissions
      if [ -f /etc/sudoers.d/10-nix-darwin-extra-config ]; then
        chmod 0440 /etc/sudoers.d/10-nix-darwin-extra-config
      fi
    '';
  };

  users.users.sean.home = "/Users/sean";

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
        ../darwin/environment.nix
        ../home/git.nix
        ../home/nvim.nix
        ../home/shell.nix
        ../darwin/shell.nix
        ../home/starship.nix
        ../home/tmux.nix

        ../profiles/darwin.nix
        ../profiles/development.nix
        ../profiles/gpg-darwin.nix
        ../profiles/notes-darwin.nix
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
