{ config, ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    enableCompletion = true;
    findNoDups = true;
    ignoreAllDups = true;
    saveNoDups = true;

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

    setOptions = [
      "BANG_HIST"
      "HIST_REDUCE_BLANKS"
    ];

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
      cat = "bat --paging=never";
      "cd.." = "cd ..";
      cd = "cd_activate_ls";
      cdi = "zi";
      e = "$VISUAL";
      g = "git";
      gg = "lazygit";
      gsip = "git reset --soft HEAD~1; git commit --all --amend --no-edit";
      la = "eza --long --group --header --all --changed --group-directories-first";
      ll = "eza --long --group --header --changed --group-directories-first";
      ls = "eza --across --group-directories-first";
      p = "python3";
      rmgitignored = "git clean -dfX -f -f";
      tree = "eza --tree";
      wget = "wget --hsts-file=$XDG_DATA_HOME/wget-hsts";
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

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    MANPAGER = "sh -c 'col -bx | bat --language=man'";
  };
}
