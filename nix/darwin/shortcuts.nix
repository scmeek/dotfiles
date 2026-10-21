{ ... }:

{
  homebrew.casks = [ "hammerspoon" ];

  home-manager.sharedModules = [
    {
      home.file.".hammerspoon/init.lua".source = ./shortcuts/init.lua;
    }
  ];
}
