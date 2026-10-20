{ pkgs, ... }:

{
  imports = [
    ./lazy.nix
    ./plugins
    ./tree-sitter.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    initLua = builtins.readFile ./init.lua;

    extraPackages = with pkgs; [
      lua-language-server
      bash-language-server
      shellcheck
      shfmt
      stylua
    ];
  };

  xdg.configFile = {
    "nvim/lua/config/options.lua".source = ./options.lua;
    "nvim/lua/config/autocmds.lua".source = ./autocmds.lua;
    "nvim/lua/config/highlights.lua".source = ./highlights.lua;
    "nvim/lua/config/keymaps.lua".source = ./keymaps.lua;
  };
}
