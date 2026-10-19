{ ... }: {
  imports = [
    ./devcontainer.nix
    ./mason.nix
    ./rust.nix
  ];

  xdg.configFile = {
    "nvim/lua/plugins/atlas.lua".source = ./atlas.lua;
    "nvim/lua/extras/development.lua".source = ./extras.lua;
    "nvim/lua/plugins/development-conform.lua".source = ./conform.lua;
    "nvim/lua/plugins/development-lspconfig.lua".source = ./lspconfig.lua;
    "nvim/lua/plugins/dap.lua".source = ./dap.lua;
    "nvim/lua/plugins/dap_ui.lua".source = ./dap_ui.lua;
    "nvim/lua/plugins/tsautotag.lua".source = ./tsautotag.lua;
  };
}
