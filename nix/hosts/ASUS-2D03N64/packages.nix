{ pkgs, ... }:

let
  # Pinned to the versions required by shared work repositories.
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
{
  home.packages = with pkgs; [
    awscli2
    k9s
    kubernetes-helm
    opentofu
    pixi
    terragrunt
  ];
}
