{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "check";
      autoUpdate = true;
      upgrade = true;
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
      "jurplel/tap/instant-space-switcher"
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
    ];
  };
}
