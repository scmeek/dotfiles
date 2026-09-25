local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.background = {
  {
    source = {
      File = wezterm.home_dir .. "/.config/wezterm/marine_bg.png",
    },

    horizontal_align = "Center",
    vertical_align = "Middle",

    repeat_x = "NoRepeat",
    repeat_y = "NoRepeat",

    hsb = {
      hue = 1.0,
      saturation = 0.9,
      brightness = 0.1,
    },
  },
}
config.color_scheme = "Material (base16)"
config.colors = {
  background = "#020004",
}
config.default_prog = {
  "/bin/sh",
  "-lc",
  "if command -v tmux >/dev/null 2>&1; then exec tmux new-session -A -s main; else exec zsh -l; fi",
}
config.disable_default_key_bindings = true
config.force_reverse_video_cursor = true
config.font = wezterm.font("Terminess Nerd Font")
config.font_size = 16
config.inactive_pane_hsb = {
  saturation = 0.25,
  brightness = 0.5,
}
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
  {
    key = "Backspace",
    mods = "CMD",
    action = wezterm.action.SendKey({ key = "\x17" }),
  },
  { key = "n", mods = "CMD", action = wezterm.action.SpawnWindow },
  { key = "h", mods = "CMD", action = wezterm.action.HideApplication },
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  { key = "C", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
  { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
  { key = "P", mods = "CTRL", action = wezterm.action.ActivateCommandPalette },
  { key = "V", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
  { key = "q", mods = "SUPER", action = wezterm.action.QuitApplication },
  { key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
  { key = "=", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
  { key = "f", mods = "CTRL|SUPER", action = wezterm.action.ToggleFullScreen },
  { key = "Enter", mods = "ALT", action = wezterm.action.ToggleFullScreen },
}
config.macos_window_background_blur = 15
config.native_macos_fullscreen_mode = true
config.set_environment_variables = {
  TERMINFO_DIRS = (
    os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
  ) .. "/terminfo",
}
config.scrollback_lines = 10000
config.term = "wezterm"
config.window_background_opacity = 0.775
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

return config
