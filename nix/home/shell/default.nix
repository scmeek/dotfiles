{ config, ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    enableCompletion = true;
    completionInit = ''
      autoload -Uz compinit
      compinit -d "${config.xdg.cacheHome}/zsh/zcompdump-$ZSH_VERSION"
    '';

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      findNoDups = true;
      path = "${config.xdg.stateHome}/zsh/history";
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 1000000;
      saveNoDups = true;
      share = true;
      size = 1000000;
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
      nfmt = "find . -type f -name \"*.nix\" -exec nixfmt {} +";
      p = "python3";
      rmgitignored = "git clean -dfX -f -f";
      shred = "shred -uvz";
      sz = "source \"$ZDOTDIR/.zshrc\"";
      tree = "eza --tree";
      wget = "wget --hsts-file=$XDG_DATA_HOME/wget-hsts";
    };

    initContent = ''
      if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
        export LESS_TERMCAP_md="$(tput bold; tput setaf 4)"
      fi

      ${builtins.readFile ./zsh-completion.zsh}
      ${builtins.readFile ./zsh-functions.zsh}
      ${builtins.readFile ./zsh-keymaps.zsh}
      ${builtins.readFile ./zsh-status-rule.zsh}

      # Machine-specific configuration (not managed by Nix)
      if [[ -f "$HOME/.config/zsh/.zshrc_local" ]]; then
        source "$HOME/.config/zsh/.zshrc_local"
      fi
    '';
  };

  xdg.cacheFile."zsh/.keep".text = "";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "sh -c 'col -bx | bat --language=man'";
    PYTHON_HISTORY = "${config.xdg.cacheHome}/python_history";
  };
}
