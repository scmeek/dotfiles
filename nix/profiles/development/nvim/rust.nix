{
  config,
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.rustup
  ];
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CARGO_NET_GIT_FETCH_WITH_CLI = "true";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };
  programs.neovim.extraPackages = [
    pkgs.rustup
  ];
  xdg.configFile."nvim/lua/plugins/crates.lua".source = ./crates.lua;
  xdg.configFile."nvim/lua/plugins/rustaceanvim.lua".source = ./rustaceanvim.lua;
  xdg.configFile."nvim/lua/extras/rust.lua".text = ''
    vim.g.lazyvim_rust_diagnostics = "bacon-ls"
    return { import = "lazyvim.plugins.extras.lang.rust" }
  '';
}
