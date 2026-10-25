{ ... }:

{
  # Decrease time to hide and show the Dock
  system.defaults.dock.autohide-time-modifier = 0.3;
  #defaults delete com.apple.dock autohide-time-modifier # Revert

  # Move windows with mouse (cmd + ctrl + click)
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  #defaults delete -g NSWindowShouldDragOnGesture # Revert

  # Reserve three-finger swipes for Safari tabs in Hammerspoon.
  system.defaults.trackpad = {
    TrackpadThreeFingerHorizSwipeGesture = 0;
    TrackpadFourFingerHorizSwipeGesture = 2;
    TrackpadThreeFingerVertSwipeGesture = 0;
    TrackpadFourFingerVertSwipeGesture = 2;
    TrackpadThreeFingerDrag = false;
  };
}
