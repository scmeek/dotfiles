{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      size = 1000000;
      save = 1000000;
      path = "${config.xdg.stateHome}/zsh/history";
      share = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      "cd.." = "cd ..";
      e = "$VISUAL";
      g = "git";
      p = "python3";
    };
  };

  # home.sessionVariables = {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  # };
}
