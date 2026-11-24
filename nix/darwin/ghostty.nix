{ ... }:

{
  homebrew.casks = [
    {
      name = "ghostty@tip";
      greedy = true;
    }
  ];

  home-manager.sharedModules = [
    {
      programs.ghostty = {
        enable = true;
        package = null;
        enableZshIntegration = false;
        settings = {
          background-opacity = 0.9;
          command = "/bin/sh -lc 'if command -v tmux >/dev/null 2>&1; then exec tmux new-session -A -s main; else exec zsh -l; fi'";
          shell-integration-features = "ssh-env,ssh-terminfo";
        };
      };

      # Inside tmux, SSH should keep sending tmux's TERM rather than xterm-ghostty.
      programs.zsh.initContent = ''
        if [[ -z $TMUX && -r "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration ]]; then
          source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
        fi
      '';
    }
  ];
}
