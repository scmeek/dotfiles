{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Keep the CLI and editor on the project's rustup toolchain, installing its
  # optional language-server components on first use.
  rustupWithAnalyzer = pkgs.symlinkJoin {
    name = "rustup-with-analyzer-${pkgs.rustup.version}";
    paths = [ pkgs.rustup ];
    postBuild = ''
      ln -sf ${pkgs.writeShellScript "rust-analyzer" ''
        set -eu
        ${pkgs.rustup}/bin/rustup component add rust-analyzer rust-src >&2
        analyzer="$(${pkgs.rustup}/bin/rustup which rust-analyzer)"
        exec "$analyzer" "$@"
      ''} "$out/bin/rust-analyzer"
    '';
  };
in
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
    rustupWithAnalyzer
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
    rustupWithAnalyzer
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
