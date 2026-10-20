{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CARGO_NET_GIT_FETCH_WITH_CLI = "true";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };

  home.packages = with pkgs; [
    bacon
    chafa
    devcontainer
    docker-client
    ghostscript
    mermaid-cli
    rustup
    texliveSmall
    ueberzugpp
    viu
  ];

  programs.neovim.extraPackages = with pkgs; [
    bacon
    black
    clang-tools
    devcontainer
    docker-client
    isort
    pyright
    python3Packages.debugpy
    prettier
    rustup
    taplo
    typescript-language-server
    yaml-language-server
    yamlfmt
    yamllint
  ];

  xdg.configFile =
    let
      luaFiles =
        dir:
        lib.mapAttrs'
          (
            name: _:
            lib.nameValuePair "nvim/lua/${dir}/${name}" {
              source = ./. + "/${dir}/${name}";
            }
          )
          (
            lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".lua" name) (
              builtins.readDir (./. + "/${dir}")
            )
          );
    in
    (luaFiles "extras") // (luaFiles "plugins");
}
