{ config, ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;
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

    syntaxHighlighting = {
      enable = true;
      styles = {
        path = "none";
        path_prefix = "none";
      };
    };

    shellGlobalAliases = {
      B = "; bell $?";
    };

    shellAliases = {
      "cd.." = "cd ..";
      cd = "cd_activate_ls";

      e = "$VISUAL";
      g = "git";
      p = "python3";

      ls = "eza --across --group-directories-first";
      ll = "eza --long --group --header --changed --group-directories-first";
      la = "eza --long --group --header --all --changed --group-directories-first";
      tree = "eza --tree";

      gg = "lazygit";
      cat = "bat --paging=never";

      rmgitignored = "git clean -dfX -f -f";
      gsip = "git reset --soft HEAD~1; git commit --all --amend --no-edit";
    };

    initContent = ''
      ${builtins.readFile ./zsh-completion.zsh}
      ${builtins.readFile ./zsh-functions.zsh}
      ${builtins.readFile ./zsh-keymaps.zsh}
      ${builtins.readFile ./zsh-status-rule.zsh}

      # GPG signing
      if [[ -t 1 ]]; then
        export GPG_TTY="$(tty)"
      fi
    '';
  };

  # home.sessionVariables = {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  # };
}
