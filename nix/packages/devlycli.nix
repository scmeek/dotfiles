{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "devlycli";
  version = "2.0.0";

  # Use the same release and checksum as the original Homebrew formula.
  src = fetchurl {
    url = "https://github.com/aarush67/devly-releases/releases/download/v${finalAttrs.version}/DevlyCLI-v${finalAttrs.version}-macos.tar.gz";
    hash = "sha256-JoEF+9SattPKPnDvXfJ7eAr7XvDQK7tH5Q5/O5HnORI=";
  };

  sourceRoot = ".";
  dontConfigure = true;
  dontBuild = true;
  # Preserve the upstream Mach-O binary and its code signature.
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 DevlyCLI "$out/bin/devly"
    runHook postInstall
  '';

  meta = {
    description = "CLI companion for the Devly menu-bar app";
    homepage = "https://devly.techfixpro.net";
    platforms = lib.platforms.darwin;
    mainProgram = "devly";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
