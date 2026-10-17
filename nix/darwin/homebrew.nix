{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "check";
      autoUpdate = true;
      upgrade = true;
      extraEnv.XDG_CONFIG_HOME = "/Users/sean/.config";
    };

    taps = [
      "aarush67/tap"
      {
        name = "jurplel/tap";
        trusted = true;
      }
    ];

    brews = [
      "aarush67/tap/devlycli"
    ];

    casks = [
      # Utilities
      "caffeine"
      "linearmouse"
      "raycast"
      "the-unarchiver"

      # Development
      "codex"
      "dbeaver-community"
      "fork"
      "wezterm@nightly"

      # Productivity
      "libreoffice"
      "netnewswire"
      "obsidian"
      "whatsapp"
      "zoom"

      # Creative tools
      "gimp"
      "inkscape"
      "musescore"
      "vlc"

      # LaTeX
      "mactex"

      # Fonts
      "font-fira-code-nerd-font"
      "font-fira-mono-nerd-font"
      "font-hack-nerd-font"
      "font-iosevka-nerd-font"
      "font-sauce-code-pro-nerd-font"
      "font-terminess-ttf-nerd-font"
      "font-victor-mono-nerd-font"

      "battle-net"
      "blender"
      "brave-browser"
      "discord"
      "godot"
      "gpg-suite"
      "keyboardcleantool"
      "macfuse"
      "ollama-app"
      "openmtp"
      "orbstack"
      "projectlibre"
      "qflipper"
      "steam"
      "transmission"
      "virtualbox"

      {
        name = "jurplel/tap/instant-space-switcher";
        trusted = true;
      }
    ];
  };
}
