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
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          # Forward navigation through SSH to remote Neovim or tmux.
          set -g @vim_navigator_pattern '(\S+/)?g?\.?(view|l?n?vim?x?|fzf|ssh)(diff)?(-wrapped)?'
        '';
      }
    ];

    extraConfig = builtins.readFile ./tmux-extra.conf;
  };
}
