#!/bin/bash

# Decrease time to hide and show the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.3
#defaults delete com.apple.dock autohide-time-modifier # Revert

# Move windows with mouse (cmd + ctrl + click)
defaults write -g NSWindowShouldDragOnGesture -bool true
#defaults delete -g NSWindowShouldDragOnGesture # Revert

# Enable repeat key when holding down
defaults write md.obsidian ApplePressAndHoldEnabled -bool false
