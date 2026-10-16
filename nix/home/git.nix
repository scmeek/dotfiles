{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "scmeek";
        email = "sean@seanmeek.com";
      };

      commit = {
        gpgsign = true;
        verbose = true;
      };

      init.defaultBranch = "main";

      pull = {
        ff = "only";
        rebase = true;
      };

      fetch = {
        prune = true;
        all = true;
        pruneTags = true;
        forceTags = true;
        tags = true;
      };

      diff = {
        colorMoved = "default";
        algorithm = "histogram";
        external = "difft";
        mnemonicPrefix = true;
        renames = true;
      };

      advice.addEmptyPathspec = false;
      pager.branch = false;

      push = {
        default = "current";
        autoSetupRemote = true;
        followTags = true;
      };

      core = {
        editor = "nvim";
        pager = "delta";
        excludesFile = "~/.config/git/ignore";
        filemode = true;
        autocrlf = "input";
      };

      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;
      merge.conflictstyle = "zdiff3";
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      help.autocorrect = "prompt";

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      filter.lfs = {
        required = true;
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
      };

      http.postBuffer = 157286400;

      url = {
        "ssh://git@github.com/".insteadOf = "https://github.com/";
        "ssh://git@gitlab.com/".insteadOf = "https://gitlab.com/";
        "ssh://git@bitbucket.org/".insteadOf = "https://bitbucket.org/";
      };

      alias = {
        unstage = "reset --";
        last = "log -1 HEAD";
        clone = "clone --recursive";
        cl = "clone";
        pu = "push";
      };

      includes = [
        { path = "${../../git/aliases}"; }
        { path = "${../../gitalias/gitalias.txt}"; }
      ];
    };
  };

  # Retain the existing global ignore definitions.
  xdg.configFile."git/ignore".source = ../../git/ignore;
}
