{ ... }:

{
  homebrew.casks = [ "hammerspoon" ];

  home-manager.sharedModules = [
    ({ pkgs, ... }: {
      home.file.".hammerspoon/init.lua".text = builtins.readFile ./init.lua;
      home.file.".hammerspoon/Spoons/Swipe.spoon".source = pkgs.fetchFromGitHub {
        owner = "mogenson";
        repo = "Swipe.spoon";
        rev = "c56520507d98e663ae0e1228e41cac690557d4aa";
        hash = "sha256-G0kuCrG6lz4R+LdAqNWiMXneF09pLI+xKCiagryBb5k=";
      };
    })
  ];
}
