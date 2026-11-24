{
  description = "Personal dotfiles and system configuration";

  inputs = {
    db9s = {
      url = "github:damien-mathieu1/db9s";
      flake = false;
    };

    gitalias = {
      url = "github:GitAlias/gitalias";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    swipe-spoon = {
      url = "github:mogenson/Swipe.spoon";
      flake = false;
    };

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
      # Set through _module.args so the exported homeModules work in other flakes.
      homeArgs._module.args = {
        inherit (inputs)
          db9s
          gitalias
          swipe-spoon
          wtfi2
          ;
      };
    in
    {
      homeModules = {
        default.imports = [
          homeArgs
          ./nix/home
        ];

        rigel.imports = [
          homeArgs
          ./nix/hosts/rigel
        ];

        "ASUS-2D03N64".imports = [
          homeArgs
          ./nix/hosts/ASUS-2D03N64
        ];
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;

      homeConfigurations."sean@ASUS-2D03N64" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit self; };
        modules = [ self.homeModules."ASUS-2D03N64" ];
      };

      darwinConfigurations."S-MBA" = nix-darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          { home-manager.sharedModules = [ homeArgs ]; }
          ./nix/hosts/S-MBA
        ];
      };
    };
}
