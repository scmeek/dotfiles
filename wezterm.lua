--
--                 °#@@@@@#.       *@@@@@@*           °°°°°.
--               O@@@@o.°#@@#   .@@@@@@@@@@@.       °@@@@@@#
--              #@@@@o    @@@  *@@°  o@@@@@@@      *@@@@@@@
--              @@@@@@.  o@@#  @@     *@@@@@@@    o@@@@@@@@
--              @@@@@@@#      #@*     @@@@@@@@o  #@@@@@@@@.
--              @@@@@@@@@*    @@@.    @#@@@@@@@ @@o@@@@@@@
--               @@@@@@@@@#   *@@@@* @@ o@@@@@@@@ O@@@@@@°
--                *@@@@@@@@*   o@@*  @@  @@@@@@@  @@@@@@@
--        .@@@O     @@@@@@@@        @@*  @@@@@@  O@@@@@@o  #
--        @@@@o      @@@@@@@       #@@   #@@@@   @@@@@@@  @@
--       O@@@@       .@@@@@°*#   *@@@    *@@@    @@@@@@@ @@
--       °@@@@       O@@@@@ @@@@@@@@°     @@     o@@@@@@@@.
--        #@@@*     *@@@@O   @@@@@@.      #       *@@@@@o
--         °@@@@@#@@@@@o       °°
--            °o##Oo.
--
--     Personal wezterm.lua file of Sean Meek <sean@seanmeek.com>

local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.animation_fps = 60
config.bold_brightens_ansi_colors = true
config.color_scheme = "Catppuccin Macchiato (Gogh)"
config.default_cursor_style = "BlinkingBlock"
config.default_prog = { "/bin/zsh", "-l", "-c", "tmux new-session -A -s main" }
config.disable_default_key_bindings = true
config.font = wezterm.font("FiraCode Nerd Font Propo", { weight = "Regular" })
config.inactive_pane_hsb = {
	saturation = 0.25,
	brightness = 0.5,
}
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
	{ key = "Backspace", mods = "CMD",   action = wezterm.action.SendKey({ key = "\x17" }) },
	{ key = "C",         mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "L",         mods = "CTRL",  action = wezterm.action.ShowDebugOverlay },
	{ key = "P",         mods = "CTRL",  action = wezterm.action.ActivateCommandPalette },
	{ key = "V",         mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c",         mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "q",         mods = "SUPER", action = wezterm.action.QuitApplication },
	{ key = "v",         mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },
}
config.macos_window_background_blur = 10
config.scrollback_lines = 10000
config.term = "wezterm"
config.window_background_opacity = 0.9
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

return config
