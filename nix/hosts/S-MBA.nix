{ config, pkgs, ... }:

{
  imports = [
    ../darwin/system.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

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
    users.sean = {
      home.username = "sean";
      home.homeDirectory = "/Users/sean";
      home.stateVersion = "26.05";
      home.sessionVariables.NVIM_ENABLE_COPILOT = "1";

      imports = [
        ../home
        ../darwin

        ../profiles/development-darwin.nix
        ../profiles/gpg-darwin.nix
        ../profiles/notes-darwin.nix
      ];

      programs.git.settings.user.signingkey = "8F73E7B76CBD3188";
      programs.zsh.shellAliases.drs = "nix flake update && darwin-rebuild build --flake .#S-MBA && sudo darwin-rebuild switch --flake .#S-MBA";
    };
  };

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
    user = "sean";
    autoMigrate = true;
    # Needed for homebrew
    extraEnv.XDG_CONFIG_HOME = config.home-manager.users.sean.xdg.configHome;
  };
}
