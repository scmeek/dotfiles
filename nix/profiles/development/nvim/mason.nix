{ pkgs, ... }: {
  home.packages = [ pkgs.bacon ];
  programs.neovim.extraPackages = [
    pkgs.bacon
    pkgs.clang-tools
    pkgs.black
    pkgs.isort
    pkgs.pyright
    pkgs.python3Packages.debugpy
    pkgs.prettier
    pkgs.taplo
    pkgs.typescript-language-server
    pkgs.yaml-language-server
    pkgs.yamlfmt
    pkgs.yamllint
  ];

  xdg.configFile."nvim/lua/plugins/development-mason.lua".text = ''
    return {
      "mason-org/mason.nvim",
      optional = true,
      opts = function(_, opts)
        local supplied_by_nix = {
          ["bacon"] = true,
          ["rust-analyzer"] = true,
          ["rustfmt"] = true,
          ["clang-format"] = true,
          ["clangd"] = true,
          ["black"] = true,
          ["debugpy"] = true,
          ["isort"] = true,
          ["pyright"] = true,
          ["prettier"] = true,
          ["taplo"] = true,
          ["yaml-language-server"] = true,
          ["yamlfmt"] = true,
          ["yamllint"] = true,
        }
        opts.ensure_installed = vim.tbl_filter(function(name)
          return not supplied_by_nix[name]
        end, opts.ensure_installed or {})
        -- Preserve the original installs and Mason's automatic LSP enabling.
        vim.list_extend(opts.ensure_installed, {
          "arduino-language-server",
          "css-lsp",
          "eslint-lsp",
          "html-lsp",
          "tailwindcss-language-server",
          "bacon-ls", -- Not available in the pinned Nixpkgs.
        })
      end,
    }
  '';
}
