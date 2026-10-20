local wezterm = require("wezterm")

return function(config)
  config.default_cwd = "\\\\wsl.localhost\\Ubuntu-22.04\\home\\sean"
  config.default_prog = {
    "wsl",
    "tmux",
    "new-session",
    "-A", -- Attach if already exists
    "-s", -- Session name
    "main",
  }

  -- Replaces the existing key bindings; add the complete ASUS list here.
  config.keys = {
    { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
    {
      key = "P",
      mods = "CTRL",
      action = wezterm.action.ActivateCommandPalette,
    },
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "Enter", mods = "ALT", action = wezterm.action.ToggleFullScreen },
    { key = "F11", action = wezterm.action.ToggleFullScreen },
  }

  return config
end
