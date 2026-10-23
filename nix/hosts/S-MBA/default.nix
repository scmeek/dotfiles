{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../darwin/system.nix
    ../../profiles/desktop-darwin-system.nix
    ../../profiles/development-darwin-system.nix
    ../../profiles/gpg-darwin-system.nix
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

  home-manager = {
    users.sean = {
      home.username = "sean";
      home.homeDirectory = "/Users/sean";
      home.stateVersion = "26.05";
      home.sessionVariables.NVIM_ENABLE_COPILOT = "1";

      imports = [
        ../../home
        ../../darwin

        ../../profiles/development-darwin.nix
        ../../profiles/gpg-darwin.nix
        ../../profiles/notes-darwin.nix
      ];

      programs.git.settings.user.signingkey = "8F73E7B76CBD3188";
      programs.zsh.shellAliases.drs = "nfmt && nix flake update && nix flake check && darwin-rebuild build --flake .#S-MBA && sudo darwin-rebuild switch --flake .#S-MBA B";

      xdg.configFile = {
        "nvim/lua/config/obsidian.lua".source = ../../profiles/notes/nvim/plugins/obsidian.lua;
        "nvim/lua/plugins/obsidian.lua".source = lib.mkForce ./nvim/plugins/obsidian.lua;
      };
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
