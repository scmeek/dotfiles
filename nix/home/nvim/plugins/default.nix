{ lib, ... }:

{
  imports = [
    ./mason.nix
  ];

  # Deploy Lua plugin specs directly; each file is its own configuration.
  xdg.configFile =
    lib.mapAttrs' (name: _: lib.nameValuePair "nvim/lua/plugins/${name}" { source = ./. + "/${name}"; })
      (
        lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) (builtins.readDir ./.)
      );
}
