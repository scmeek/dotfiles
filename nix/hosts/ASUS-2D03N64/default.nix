{
  config,
  lib,
  pkgs,
  self,
  ...
}:

{
  imports = [
    ../../home
    ./git.nix
    ./shell.nix
    ../../profiles/development
    ../../profiles/notes/nvim
    ./nvim
  ];

  home = {
    username = "sean";
    homeDirectory = "/home/sean";
    stateVersion = "26.05";
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;

  # Update GPU drivers, if necessary
  home.activation.updateGpuDrivers =
    let
      gpu = config.targets.genericLinux.gpu;
    in
    lib.mkIf gpu.enable (
      lib.hm.dag.entryAfter [ "writeBoundary" "checkExistingGpuDrivers" ] ''
        if [[ "$(readlink /run/opengl-driver || true)" != "${gpu.drivers}" ]]; then
          run /usr/bin/sudo ${lib.getExe gpu.setupPackage}
        fi
      ''
    );

  home.packages = with pkgs; [
    awscli2
    k9s
    pixi
  ];

  # symlink home-manager to /nix/store/...-source for config file
  xdg.configFile."home-manager".source = self;
}
