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
}
