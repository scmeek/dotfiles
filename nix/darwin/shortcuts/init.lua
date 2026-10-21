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
