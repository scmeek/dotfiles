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

config.bold_brightens_ansi_colors = true
config.color_scheme = "Catppuccin Macchiato (Gogh)"
config.default_prog = { "/bin/zsh", "-l", "-c", "tmux new-session -A -s main" }
config.font = wezterm.font("FiraCode Nerd Font Propo", { weight = "Light" })
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
}
config.macos_window_background_blur = 10
config.scrollback_lines = 10000
config.term = "wezterm"
config.window_background_opacity = 0.9
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

return config
