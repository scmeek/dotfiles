{ ... }:

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
      # Don't auto upgrade homebrew itself, which is managed (pinned and
      # upgraded) by nix
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
}
