{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation rec {
  pname = "devlycli";
  version = "2.0.0";

  # Use the same release and checksum as the original Homebrew formula.
  src = fetchurl {
    url = "https://github.com/aarush67/devly-releases/releases/download/v${version}/DevlyCLI-v${version}-macos.tar.gz";
    sha256 = "268105fbd49ab6d3ca3e70ef5df27b780afb5ef0d02bbb47e50e7f3b91e73912";
  };

  sourceRoot = ".";
  dontConfigure = true;
  dontBuild = true;
  # Preserve the upstream Mach-O binary and its code signature.
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    install -m755 DevlyCLI "$out/bin/devly"
    runHook postInstall
  '';

  meta = {
    description = "CLI companion for the Devly menu-bar app";
    homepage = "https://devly.techfixpro.net";
    platforms = lib.platforms.darwin;
    mainProgram = "devly";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
