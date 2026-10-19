{ lib, ... }:

let
  plist = lib.generators.toPlist { escape = true; };
  escape = builtins.fromJSON ''"\u001b"'';
  menu = path: escape + lib.replaceStrings [ "->" ] [ escape ] path;
  arrows = builtins.fromJSON ''{"up":"\uf700","down":"\uf701","left":"\uf702","right":"\uf703"}'';

  windowKeys = {
    "${menu "Window->Move & Resize->Left"}" = "@${arrows.left}";
    "${menu "Window->Fill"}" = "@${arrows.up}";
    "${menu "Window->Move & Resize->Right"}" = "@${arrows.right}";
    "${menu "Window->Minimize"}" = "@${arrows.down}";
  };

  # Update only our shortcuts; replacing the whole dictionary would erase unrelated bindings.
  mergeDefaults =
    domain: key: entries:
    "run /usr/bin/defaults write ${lib.escapeShellArg domain} ${lib.escapeShellArg key} -dict-add "
    + lib.concatStringsSep " " (
      lib.mapAttrsToList (
        name: value: "${lib.escapeShellArg (plist name)} ${lib.escapeShellArg (plist value)}"
      ) entries
    );
in
{
  home.activation.setDarwinShortcuts = lib.hm.dag.entryAfter [ "setDarwinDefaults" ] ''
    ${mergeDefaults "NSGlobalDomain" "NSUserKeyEquivalents" windowKeys}
  '';
}
