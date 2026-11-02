{ config, lib, ... }:

{
  nix-homebrew.extraEnv = {
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  homebrew = {
    enable = true;
    enableZshIntegration = true;
    global.autoUpdate = false;

    brews = [ "mas" ];

    masApps = {
      "1Blocker" = 1365531024;
      Devly = 6759269801;
      NepTunes = 1006739057;
      Vinegar = 1591303229;
      WireGuard = 1451685025;
    };

    onActivation = {
      cleanup = "check";
      # Inline auto-update restarts the nix-homebrew wrapper and loses mas from PATH.
      # Refresh metadata separately below, before running Bundle.
      autoUpdate = false;
      upgrade = true;
    };

    taps = [
      {
        name = "jurplel/tap";
        trusted = true;
      }
    ];

  };

  system.activationScripts.homebrew.text = lib.mkBefore ''
    if [ -x ${lib.escapeShellArg "${config.homebrew.prefix}/bin/brew"} ]; then
      echo >&2 "Refreshing Homebrew package metadata..."
      sudo --user=${lib.escapeShellArg config.homebrew.user} --set-home \
        ${lib.escapeShellArg "${config.homebrew.prefix}/bin/brew"} update
    fi
  '';
}
