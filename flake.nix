{
  description = "Personal dotfiles and system configuration";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    ...
  }: {
    homeManagerModules.default = import ./nix/home;

    darwinConfigurations."S-MBA" = nix-darwin.lib.darwinSystem {
      modules = [
        ./nix/darwin/default.nix

        home-manager.darwinModules.home-manager

        nix-homebrew.darwinModules.nix-homebrew
      ];
    };
  };
}
