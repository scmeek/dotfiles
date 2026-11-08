{ ... }:

{
  imports = [ ./development-darwin-system.nix ];

  homebrew.brews = [
    "xcodegen"
    "zstd"
    "glslang"
  ];

  homebrew.casks = [ "dotnet-sdk" ];
}
