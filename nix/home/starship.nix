{ ... }:

{
  programs.starship = {
    enable = true;

    enableZshIntegration = false;
  };

  xdg.configFile."starship/starship.toml".source =
    ../../starship.toml;
}
