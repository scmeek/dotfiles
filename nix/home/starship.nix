{ ... }:

{
  programs.starship = {
    enable = true;

    enableZshIntegration = true;
  };

  xdg.configFile."starship/starship.toml".source =
    ../../starship.toml;
}
