{
  config,
  lib,
  self,
  ...
}:

let
  gpu = config.targets.genericLinux.gpu;
in
{
  imports = [
    ../../home
    ../../profiles/development
    ../../profiles/notes/nvim
    ./git.nix
    ./nvim
    ./packages.nix
    ./shell.nix
  ];

  home = {
    username = "sean";
    homeDirectory = "/home/sean";
    stateVersion = "26.05";
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;

  # Install updated GPU drivers instead of only warning about them.
  home.activation.updateGpuDrivers = lib.mkIf gpu.enable (
    lib.hm.dag.entryAfter [ "writeBoundary" "checkExistingGpuDrivers" ] ''
      if [[ "$(readlink /run/opengl-driver || true)" != "${gpu.drivers}" ]]; then
        run /usr/bin/sudo ${lib.getExe gpu.setupPackage}
      fi
    ''
  );

  # Lets home-manager find this flake without --flake.
  xdg.configFile."home-manager".source = self;
}
