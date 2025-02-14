-- This file should be symlinked to $HOME/.wezterm in Windows

local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.bold_brightens_ansi_colors = false
config.color_scheme = "Catppuccin Mocha"
config.default_prog = { "wsl", "tmux", "new-session", "-A", "-s", "main", "&&", "exit" }
config.disable_default_key_bindings = true
config.force_reverse_video_cursor = true
config.font = wezterm.font("Hack Nerd Font Propo")
config.font_size = 12
config.inactive_pane_hsb = {
	saturation = 0.25,
	brightness = 0.5,
}
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
	{ key = "C", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
	{ key = "P", mods = "CTRL", action = wezterm.action.ActivateCommandPalette },
	{ key = "V", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
}
config.scrollback_lines = 10000
config.term = "wezterm"
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 4,
	right = 4,
	top = 0,
	bottom = 4,
}

return config
