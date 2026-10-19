{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";
    prefix = "C-Space";
    baseIndex = 1;
    escapeTime = 20;
    clock24 = false;
    historyLimit = 100000;
    mouse = true;
    keyMode = "vi";
    focusEvents = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      vim-tmux-navigator
    ];

    extraConfig = builtins.readFile ./tmux-extra.conf;
  };
}
