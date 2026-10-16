{
  description = "Personal dotfiles and Home Manager configuration";

  outputs = { self, ... }: {
    homeManagerModules.default = import ./nix/home;
  };
}
