
{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "none";
      autoUpdate = false;
      upgrade = false;
    };

    casks = [
      # Utilities
      "caffeine"
      "linearmouse"
      "raycast"
      "the-unarchiver"

      # Development
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

      # Other applications
      "ollama-app"
      "openmtp"
      "qflipper"

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
    ];
  };
}

