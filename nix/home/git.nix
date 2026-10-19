{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    ignores = [
      # macOS folder metadata files
      ".DS_Store"
      "._.DS_Store"
      "**/.DS_Store"
      "**/._.DS_Store"
    ];

    includes = [
      { path = "${../../gitalias/gitalias.txt}"; }
    ];

    settings = {
      user = {
        name = "scmeek";
        email = "sean@seanmeek.com";
      };

      commit = {
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

        # Modified version of lg2 from https://stackoverflow.com/a/34467298
        l = lib.concatStringsSep " " [
          "log"
          "--graph"
          "--abbrev-commit"
          "--decorate"
          "--date=format:'%Y-%m-%d %I:%M %p'"
          (lib.concatStrings [
            "--format=format:'"
            "%C(bold blue)%h%C(reset)"
            " - %C(cyan)%ad%C(reset)"
            " %C(green)(%ar)%C(reset)"
            "%C(auto)%d%C(reset)"
            "%n''%w(100,10,10)"
            "%C(white)%s%C(reset)"
            " %C(magenta)- %aN%C(reset)'"
          ])
        ];

        # summary: print a helpful summary of some typical metrics
        summary = ''
          !f() {
            printf "Summary of this branch...\n"
            printf "%s\n" $(git rev-parse --abbrev-ref HEAD)
            printf "%s first commit timestamp\n" $(
              git log --date-order --format=%cI | tail -1
            )
            printf "%s latest commit timestamp\n" $(git log -1 --date-order --format=%cI)
            printf "%d commit count\n" $(git rev-list --count HEAD)
            printf "%d date count\n" $(
              git log --format=oneline --format="%ad" --date=format:"%Y-%m-%d" |
                awk '{a[$0]=1}END{for(i in a){n++;} print n}'
            )
            printf "%d tag count\n" $(git tag | wc -l)
            printf "%d author count\n" $(
              git log --format=oneline --format="%aE" |
                awk '{a[$0]=1}END{for(i in a){n++;} print n}'
            )
            printf "%d committer count\n" $(
              git log --format=oneline --format="%cE" |
                awk '{a[$0]=1}END{for(i in a){n++;} print n}'
            )
            printf "%d local branch count\n" $(git branch | grep -v " -> " | wc -l)
            printf "%d remote branch count\n" $(git branch -r | grep -v " -> " | wc -l)

            printf "\nSummary of this directory...\n"
            printf "%s\n" $(pwd)
            printf "%d file count via git ls-files\n" $(git ls-files | wc -l)
            printf "%d file count via find command\n" $(find . | wc -l)
            printf "%d disk usage\n" $(du -s | awk '{print $1}')

            printf "\nMost-active authors, with commit count and %%...\n"
            git log-of-count-and-email | head -7

            printf "\nMost-active dates, with commit count and %%...\n"
            git log-of-count-and-day | head -7

            printf "\nMost-active files, with churn count\n"
            git churn | head -7
          }
          f
        '';
      };

      safe.directory = "/etc/nixos";
    };
  };

  home.packages = with pkgs; [
    delta
    difftastic
    git-lfs
  ];
}
