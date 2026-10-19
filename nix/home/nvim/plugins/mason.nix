{ pkgs, ... }: {
  programs.neovim.extraPackages = [
    pkgs.lua-language-server
    pkgs.bash-language-server
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.stylua
  ];

  xdg.configFile."nvim/lua/plugins/mason.lua".text = ''
    return {
      "mason-org/mason.nvim",
      optional = true,
      opts = function(_, opts)
        opts.PATH = "append"
        local supplied_by_nix = {
          ["lua-language-server"] = true,
          ["bash-language-server"] = true,
          ["shellcheck"] = true,
          ["shfmt"] = true,
          ["stylua"] = true,
        }
        opts.ensure_installed = vim.tbl_filter(function(name)
          return not supplied_by_nix[name]
        end, opts.ensure_installed or {})
      end,
    }
  '';
}
