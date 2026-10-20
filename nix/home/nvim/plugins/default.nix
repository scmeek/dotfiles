{ lib, pkgs, ... }:

{
  xdg.configFile =
    lib.mapAttrs' (name: _: lib.nameValuePair "nvim/lua/plugins/${name}" { source = ./. + "/${name}"; })
      (
        lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) (builtins.readDir ./.)
      );
}
