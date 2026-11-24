{ ... }:

{
  homebrew.casks = [ "hammerspoon" ];

  home-manager.sharedModules = [
    (
      { swipe-spoon, ... }:
      {
        home.file.".hammerspoon/init.lua".text = builtins.readFile ./init.lua;
        home.file.".hammerspoon/Spoons/Swipe.spoon".source = swipe-spoon;
      }
    )
  ];
}
