{ config, pkgs, ... }:

{
  imports = [
    ../../darwin/system.nix
    ../../profiles/desktop/darwin-system.nix
    ../../profiles/development/darwin-system.nix
    ../../profiles/development/nxnative-darwin-system.nix
    ../../profiles/gpg/darwin-system.nix
    ./homebrew.nix
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
  home-manager.users.sean = ./home.nix;

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
