local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Material (base16)"
config.colors = {
	background = "#020004",
}
config.default_prog = { "/bin/zsh", "-l", "-c", "tmux new-session -A -s main" }
config.disable_default_key_bindings = true
config.force_reverse_video_cursor = true
config.font = wezterm.font("SauceCodePro Nerd Font")
config.font_size = 14.5
config.inactive_pane_hsb = {
	saturation = 0.25,
	brightness = 0.5,
}
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
	{ key = "Backspace", mods = "CMD", action = wezterm.action.SendKey({ key = "\x17" }) },
	{ key = "n", mods = "CMD", action = wezterm.action.SpawnWindow },
	{ key = "h", mods = "CMD", action = wezterm.action.HideApplication },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
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
	TERMINFO_DIRS = "~/.local/share/terminfo",
}
config.scrollback_lines = 10000
config.term = "wezterm"
config.window_background_opacity = 0.775
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 4,
	right = 4,
	top = 0,
	bottom = 4,
}

return config
