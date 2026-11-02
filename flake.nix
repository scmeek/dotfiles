{
  description = "Personal dotfiles and system configuration";

  inputs = {
    self.submodules = true;

    db9s = {
      url = "github:damien-mathieu1/db9s";
      flake = false;
    };

    gitalias = {
      url = "github:GitAlias/gitalias";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    wtfi2 = {
      url = "github:kanywst/wtfi2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      ...
    }:
    let
      homeModules = {
        default = {
          imports = [ ./nix/home ];

          _module.args = {
            inherit (inputs)
              db9s
              gitalias
              nixpkgs-unstable
              wtfi2
              ;
          };
        };

        rigel = {
          imports = [
            homeModules.default
            ./nix/hosts/rigel.nix
          ];
        };

        "ASUS-2D03N64" = {
          imports = [
            homeModules.default
            ./nix/hosts/ASUS-2D03N64
          ];
        };
      };
    in
    {
      inherit homeModules;

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;

      homeConfigurations."sean@ASUS-2D03N64" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };

        extraSpecialArgs = {
          inherit self;
        };

        modules = [
          homeModules."ASUS-2D03N64"
        ];
      };

      darwinConfigurations."S-MBA" = nix-darwin.lib.darwinSystem {
        modules = [
          ./nix/hosts/S-MBA

          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew

          {
            home-manager.extraSpecialArgs = {
              inherit (inputs)
                db9s
                gitalias
                nixpkgs-unstable
                wtfi2
                ;
            };
          }
        ];
      };
    };
}
