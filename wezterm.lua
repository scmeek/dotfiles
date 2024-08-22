local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.animation_fps = 1
config.bold_brightens_ansi_colors = true
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"
config.default_prog = { "/bin/zsh", "-l", "-c", "tmux new-session -A -s main" }
config.disable_default_key_bindings = true
config.force_reverse_video_cursor = true
config.front_end = "WebGpu"
config.font = wezterm.font("FiraCode Nerd Font Propo", { weight = "Regular" })
config.font_size = 16
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
}
config.macos_window_background_blur = 7
config.set_environment_variables = {
	TERMINFO_DIRS = "~/.local/share/terminfo",
}
config.scrollback_lines = 10000
config.term = "wezterm"
config.window_background_opacity = 0.85
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

return config
