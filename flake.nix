{
  description = "Personal dotfiles and system configuration";

  inputs = {
    self.submodules = true;

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
    {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
      homeManagerModules = {
        default = {
          imports = [ ./nix/home ];
          _module.args.gitalias = inputs.gitalias;
        };
        rigel = {
          imports = [
            self.homeManagerModules.default
            ./nix/hosts/rigel.nix
          ];
        };
      };

      darwinConfigurations."S-MBA" = nix-darwin.lib.darwinSystem {
        modules = [
          ./nix/hosts/S-MBA.nix

          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          { home-manager.extraSpecialArgs.gitalias = inputs.gitalias; }
        ];
      };
    };
}
