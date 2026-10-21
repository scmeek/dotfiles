{ lib, ... }:

{
  imports = [ ./notes ];

  # Enable repeat key when holding down
  targets.darwin.defaults."md.obsidian".ApplePressAndHoldEnabled = false;

  home.file.".hammerspoon/init.lua".text = lib.mkAfter ''
    hs.hotkey.bind({ "cmd" }, "5", function()
      hs.application.launchOrFocusByBundleID("md.obsidian")
    end)
  '';
}
