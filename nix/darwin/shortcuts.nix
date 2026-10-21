{ ... }:

{
  homebrew.casks = [ "hammerspoon" ];

  home-manager.sharedModules = [
    {
      home.file.".hammerspoon/init.lua".text = builtins.readFile ./shortcuts/init.lua;
    }
  ];
}
