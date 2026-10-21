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

  };
}
