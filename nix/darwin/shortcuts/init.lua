hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(false)
hs.window.animationDuration = 0

local function withWindow(action)
  return function()
    local window = hs.window.focusedWindow()
    if window then
      action(window)
    end
  end
end

hs.hotkey.bind(
  { "cmd" },
  "left",
  withWindow(function(window)
    window:moveToUnit({ 0, 0, 0.5, 1 })
  end)
)

hs.hotkey.bind(
  { "cmd" },
  "right",
  withWindow(function(window)
    window:moveToUnit({ 0.5, 0, 0.5, 1 })
  end)
)

hs.hotkey.bind(
  { "cmd" },
  "up",
  withWindow(function(window)
    window:maximize()
  end)
)

hs.hotkey.bind(
  { "cmd" },
  "down",
  withWindow(function(window)
    window:minimize()
  end)
)

hs.hotkey.bind({ "cmd" }, "1", function()
  hs.application.launchOrFocusByBundleID("com.github.wez.wezterm")
end)

hs.hotkey.bind({ "cmd" }, "2", function()
  hs.application.launchOrFocusByBundleID("com.apple.Safari")
end)

hs.hotkey.bind({ "cmd" }, "3", function()
  hs.application.launchOrFocusByBundleID("com.apple.Music")
end)

hs.hotkey.bind({ "cmd" }, "4", function()
  hs.application.launchOrFocusByBundleID("com.apple.MobileSMS")
end)

-- Safari: natural motion, three fingers left for the next tab, right for the previous tab.
-- Swipe up to open a tab, down to close the current tab.
local swipeKeys = {
  left = { { "ctrl" }, "tab" },
  right = { { "ctrl", "shift" }, "tab" },
  up = { { "cmd" }, "t" },
  down = { { "cmd" }, "w" },
}
local lastSwipe
hs.loadSpoon("Swipe")
spoon.Swipe:start(3, function(direction, distance, id)
  local keys = swipeKeys[direction]
  if id == lastSwipe or distance < 0.08 or not keys then
    return
  end
  lastSwipe = id -- One tab per swipe.
  local app = hs.application.frontmostApplication()
  if app and app:bundleID() == "com.apple.Safari" then
    hs.eventtap.keyStroke(keys[1], keys[2], 0, app)
  end
end)
