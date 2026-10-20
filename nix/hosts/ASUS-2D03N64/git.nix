{ lib, ... }:

{
  programs.git.settings = {
    user = {
      name = lib.mkForce "s-meek";
      email = lib.mkForce "s.meek@astroscale-us.com";
    };

    safe.directory = lib.mkAfter [
      "%(prefix)///wsl.localhost/Ubuntu-22.04/home/sean/source/dotfiles"
    ];

    # Replace all shared URL rewrites with the ASUS rule.
    url = lib.mkForce {
      "ssh://git@github.astroscale-us.com/".insteadOf = "https://github.astroscale-us.com/";
    };
  };
}
