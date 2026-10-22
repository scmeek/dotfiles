{ lib, ... }:

let
  lua = lib.generators.mkLuaInline;
  copy = lua ''
    wezterm.action_callback(function(window, pane)
        if window:get_selection_text_for_pane(pane) ~= "" then
          window:perform_action(wezterm.action.CopyTo("Clipboard"), pane)
        else
          -- Send a dedicated copy sequence without sending Ctrl-C to the shell.
          window:perform_action(wezterm.action.SendString("\x1b[5;30012~"), pane)
        end
      end)'';

  settings = {
    animation_fps = 24;
    colors.background = "#000000";
    color_scheme = "Idle Toes (Gogh)";
    cursor_blink_rate = 1000;
    cursor_blink_ease_in = "EaseOut";
    cursor_blink_ease_out = "EaseOut";
    default_cursor_style = "BlinkingBlock";
    default_prog = [
      "/bin/sh"
      "-lc"
      "if command -v tmux >/dev/null 2>&1; then exec tmux new-session -A -s main; else exec zsh -l; fi"
    ];
    disable_default_key_bindings = true;
    force_reverse_video_cursor = true;
    font = lua ''wezterm.font("Terminess Nerd Font")'';
    font_size = 16;
    inactive_pane_hsb = {
      saturation = 0.25;
      brightness = 0.5;
    };
    hide_tab_bar_if_only_one_tab = true;
    keys = [
      {
        key = "Backspace";
        mods = "CMD";
        action = lua ''wezterm.action.SendKey({ key = "\x17" })'';
      }
      {
        key = "n";
        mods = "CMD";
        action = lua "wezterm.action.SpawnWindow";
      }
      {
        key = "h";
        mods = "CMD";
        action = lua "wezterm.action.HideApplication";
      }
      {
        key = "w";
        mods = "CMD";
        action = lua "wezterm.action.CloseCurrentTab({ confirm = false })";
      }
      {
        key = "C";
        mods = "SUPER";
        action = copy;
      }
      {
        key = "L";
        mods = "CTRL";
        action = lua "wezterm.action.ShowDebugOverlay";
      }
      {
        key = "P";
        mods = "CTRL";
        action = lua "wezterm.action.ActivateCommandPalette";
      }
      {
        key = "V";
        mods = "SUPER";
        action = lua ''wezterm.action.PasteFrom("Clipboard")'';
      }
      {
        key = "c";
        mods = "SUPER";
        action = copy;
      }
      {
        key = "q";
        mods = "SUPER";
        action = lua "wezterm.action.QuitApplication";
      }
      {
        key = "v";
        mods = "SUPER";
        action = lua ''wezterm.action.PasteFrom("Clipboard")'';
      }
      {
        key = "-";
        mods = "SUPER";
        action = lua "wezterm.action.DecreaseFontSize";
      }
      {
        key = "=";
        mods = "SUPER";
        action = lua "wezterm.action.IncreaseFontSize";
      }
      {
        key = "f";
        mods = "CTRL|SUPER";
        action = lua "wezterm.action.ToggleFullScreen";
      }
      {
        key = "Enter";
        mods = "ALT";
        action = lua "wezterm.action.ToggleFullScreen";
      }
    ];
    line_height = 1.1;
    macos_window_background_blur = 4;
    native_macos_fullscreen_mode = true;
    scrollback_lines = 10000;
    term = "wezterm";
    window_background_opacity = 0.775;
    window_close_confirmation = "NeverPrompt";
    window_decorations = "RESIZE";
    window_padding = {
      left = 0;
      right = 0;
      top = 0;
      bottom = 0;
    };
  };
in
{
  homebrew.casks = [
    {
      name = "wezterm@nightly";
      greedy = true;
    }
  ];

  home-manager.sharedModules = [
    ({ config, pkgs, ... }: {
      home.sessionVariables.TERMINFO_DIRS = "${pkgs.wezterm.terminfo}/share/terminfo:";

      xdg.configFile."wezterm/wezterm.lua".text = ''
        local wezterm = require("wezterm")
        local config = wezterm.config_builder and wezterm.config_builder() or {}
        local settings = ${
          lib.generators.toLua { } (
            settings
            // {
              set_environment_variables.TERMINFO_DIRS = config.home.sessionVariables.TERMINFO_DIRS;
            }
          )
        }

        for key, value in pairs(settings) do
          config[key] = value
        end

        return config
      '';
    })
  ];
}
