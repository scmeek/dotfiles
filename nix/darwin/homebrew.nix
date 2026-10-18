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
      {
        name = "jurplel/tap";
        trusted = true;
      }
    ];

    casks = [
      # Utilities
      "caffeine"
      "linearmouse"
      "the-unarchiver"

      # Development
      "codex"
      "dbeaver-community"
      "fork"
      "wezterm@nightly"

      # Productivity
      "libreoffice"
      "netnewswire"
      "whatsapp"
      "zoom"

      # Creative tools
      "gimp"
      "inkscape"
      "musescore"
      "vlc"

      # LaTeX
      "mactex"

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
