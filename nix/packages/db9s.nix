{
  lib,
  rustPlatform,
  src,
}:

let
  cargoToml = builtins.fromTOML (builtins.readFile "${src}/Cargo.toml");
in
rustPlatform.buildRustPackage {
  pname = "db9s";
  version =
    if builtins.isAttrs cargoToml.package.version then
      cargoToml.workspace.package.version
    else
      cargoToml.package.version;

  inherit src;

  cargoLock.lockFile = "${src}/Cargo.lock";

  meta = {
    description = "Terminal UI for Postgres, MongoDB, Redis and RabbitMQ";
    homepage = "https://github.com/damien-mathieu1/db9s";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    mainProgram = "db9s";
  };
}
