{
  config,
  lib,
  pkgs,
  ...
}:

let
  luaFiles =
    dir:
    lib.listToAttrs (
      map (
        file:
        lib.nameValuePair "nvim/lua/${lib.removePrefix "${toString dir}/" (toString file)}" {
          source = file;
        }
      ) (lib.filesystem.listFilesRecursive dir)
    );
in
{
  options.dotfiles.nvim.luaDirs = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    default = [ ];
    description = ''
      Directories mirrored into ~/.config/nvim/lua. Each file is linked
      individually, so other modules can override a single file.
    '';
  };

  config = {
    dotfiles.nvim.luaDirs = [ ./lua ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      initLua = builtins.readFile ./init.lua;
      plugins = [ pkgs.vimPlugins.lazy-nvim ];

      extraPackages = with pkgs; [
        gcc
        tree-sitter
        lua-language-server
        bash-language-server
        shellcheck
        shfmt
        stylua
      ];
    };

    xdg.configFile = lib.mkMerge (map luaFiles config.dotfiles.nvim.luaDirs);
  };
}
