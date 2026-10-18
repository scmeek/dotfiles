{ ... }:

{
  programs.bat = {
    enable = true;

    config = {
      color = "always";
      italic-text = "always";
      map-syntax = [
        "*.ino:C++"
        ".ignore:Git Ignore"
      ];
      style = "plain";
      theme = "ansi";
    };
  };

  programs.zsh.shellGlobalAliases."--help" = "--help 2>&1 | bat --language=help";
}
