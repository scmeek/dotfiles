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

  home.packages =
    let
      terragrunt = pkgs.stdenvNoCC.mkDerivation {
        pname = "terragrunt";
        version = "1.1.6";

        src = pkgs.fetchurl {
          url = "https://github.com/gruntwork-io/terragrunt/releases/download/v1.1.6/terragrunt_linux_amd64";
          hash = "sha256-11qAuyZHWLoA2ryxf0tQf82rTKkNnkH5Z1DfA2v2mwQ=";
        };

        dontUnpack = true;

        installPhase = ''
          install -Dm755 "$src" "$out/bin/terragrunt"
        '';
      };

      opentofu = pkgs.stdenvNoCC.mkDerivation {
        pname = "opentofu";
        version = "1.13.1";

        src = pkgs.fetchurl {
          url = "https://github.com/opentofu/opentofu/releases/download/v1.13.1/tofu_1.13.1_linux_amd64.zip";
          hash = "sha256-jMvG+O4h0oJ3FfPG4IqbPgIJseYgV8BQZ+8RfgR8GoA=";
        };

        nativeBuildInputs = [ pkgs.unzip ];

        unpackPhase = ''
          unzip "$src" tofu
        '';

        installPhase = ''
          install -Dm755 tofu "$out/bin/tofu"
        '';
      };
    in
    with pkgs;
    [
      awscli2
      k9s
      pixi
      terragrunt
      opentofu
    ];

  # symlink home-manager to /nix/store/...-source for config file
  xdg.configFile."home-manager".source = self;
}
