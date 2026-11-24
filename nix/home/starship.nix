{ config, lib, ... }:

{
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.dataHome}/starship/cache";

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;
      command_timeout = 1000;
      continuation_prompt = "▸▹ ";
      scan_timeout = 100;
      format = lib.concatStrings [
        "($nix_shell$container$fill$cmd_duration$git_metrics$time \n)"
        "$username"
        "$hostname"
        "$localip"
        "$shlvl"
        "$shell"
        "$env_var"
        "$jobs"
        "$character"
        "$sudo "
      ];
      right_format = lib.concatStrings [
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$hg_branch"
        "$pijul_channel"
        "$docker_context"
        "$package"
        "$c"
        "$cpp"
        "$cmake"
        "$cobol"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$raku"
        "$rlang"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$solidity"
        "$swift"
        "$terraform"
        "$vlang"
        "$vagrant"
        "$zig"
        "$buf"
        "$conda"
        "$pixi"
        "$meson"
        "$spack"
        "$memory_usage"
        "$aws"
        "$gcloud"
        "$openstack"
        "$azure"
        "$crystal"
        "$custom"
        "$status"
        "$os"
        "$battery "
      ];
      fill = {
        symbol = " ";
      };
      character = {
        format = "$symbol";
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
        vimcmd_symbol = "[■](bold green)";
        vimcmd_replace_one_symbol = "◌";
        vimcmd_replace_symbol = "□";
        vimcmd_visual_symbol = "▼";
      };
      env_var = {
        VIMSHELL = {
          format = "[$env_value]($style)";
        };
      };
      sudo = {
        format = "[$symbol]($style)";
        symbol = "!";
        disabled = false;
      };
      username = {
        format = "[$user]($style)";
        show_always = false;
      };
      directory = {
        home_symbol = "󰠧 ";
        truncation_length = 2;
        truncation_symbol = "  ";
        read_only = "  ";
        use_os_path_sep = true;
        format = "[$path]($style)[$read_only]($read_only_style)";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style)";
      };
      cmd_duration = {
        format = "[⧖ $duration]($style)";
      };
      jobs = {
        format = "[$symbol$number]($style) ";
        symbol = "▶";
      };
      hostname = {
        ssh_only = true;
        format = "[@$hostname]($style)";
        disabled = false;
      };
      localip = {
        ssh_only = true;
        format = " [\\($localipv4\\)]($style) ";
        disabled = false;
      };
      time = {
        disabled = false;
        format = "[    $time]($style)";
        time_format = "%R";
        utc_time_offset = "local";
      };
      battery = {
        disabled = true;
        format = "[  $percentage $symbol]($style)";
        full_symbol = "█";
        charging_symbol = "↑";
        discharging_symbol = "↓";
        unknown_symbol = "░";
        empty_symbol = "▃";
      };
      git_branch = {
        format = "  [ $branch(:$remote_branch)]($style)";
        symbol = "△";
        truncation_symbol = "⋯";
        truncation_length = 16;
        only_attached = true;
      };
      git_metrics = {
        disabled = false;
        format = "(  [▴ $added]($added_style))([▿ $deleted]($deleted_style))";
        ignore_submodules = true;
      };
      git_status = {
        disabled = true;
        format = "([⎪$ahead_behind$staged$modified$untracked$renamed$deleted$conflicted$stashed⎥]($style))";
        conflicted = "◪◦";
        ahead = "▴│\${count}│";
        behind = "▿│\${count}│";
        diverged = "◇ ▴┤\${ahead_count}│▿┤\${behind_count}│";
        untracked = "◌◦";
        stashed = "◃◈";
        modified = "●◦";
        staged = "▪┤$count│";
        renamed = "◎◦";
        deleted = "✕";
      };
      deno = {
        format = "  [deno]($style) [$version]($style)";
        version_format = "\${raw}";
      };
      lua = {
        format = "  [lua]($style) [\${version}]($style)";
        version_format = "\${raw}";
        symbol = "⨀ ";
      };
      nodejs = {
        format = "  [node]($style) [($version)]($style)";
        version_format = "\${raw}";
        detect_files = [
          "package-lock.json"
          "yarn.lock"
        ];
        detect_folders = [
          "node_modules"
        ];
        detect_extensions = [ ];
      };
      python = {
        format = "  [py]($style) [\${version}]($style)";
        symbol = "⌉⌊ ";
        version_format = "\${raw}";
      };
      ruby = {
        format = "  [rb]($style) [\${version}]($style)";
        symbol = "◆ ";
        version_format = "\${raw}";
      };
      rust = {
        format = "  [rust]($style) [$version]($style)";
        symbol = "⊃ ";
        version_format = "\${raw}";
      };
      package = {
        disabled = true;
        format = "  [v($version)]($style)";
        version_format = "\${raw}";
        symbol = "◨ ";
      };
      swift = {
        format = "  [sw]($style) [\${version}]($style)";
        symbol = "◁ ";
        version_format = "\${raw}";
      };
      aws = {
        disabled = true;
        format = "  [aws]($style) [$profile $region]($style)";
        symbol = "▲ ";
      };
      buf = {
        symbol = "■ ";
        format = "  [buf]($style) [$version $buf_version]($style)";
      };
      c = {
        symbol = "ℂ ";
        format = "  [c]($style) [($version(-$name))]($style)";
      };
      cpp = {
        symbol = "ℂ ";
        format = "  [c++]($style) [($version(-$name))]($style)";
      };
      conda = {
        symbol = "◯ ";
        format = "  [conda]($style) [$environment]($style)";
      };
      pixi = {
        symbol = "■ ";
        format = "  [pixi]($style) [$version ($environment )]($style)";
      };
      dart = {
        symbol = "◁◅ ";
        format = "  [dart]($style) [($version )]($style)";
      };
      docker_context = {
        symbol = "◧ ";
        format = "  [docker]($style [$context]($style)";
      };
      elixir = {
        symbol = "△ ";
        format = "  [exs]($style) [$version OTP $otp_version ]($style)";
      };
      elm = {
        symbol = "◩ ";
        format = "  [elm]($style) [($version )]($style)";
      };
      golang = {
        symbol = "∩ ";
        format = "  [go]($style) [($version )]($style)";
      };
      haskell = {
        symbol = "❯λ ";
        format = "  [hs]($style) [($version )]($style)";
      };
      java = {
        symbol = "∪ ";
        format = "  [java]($style) [(\${version} )]($style)";
      };
      julia = {
        symbol = "◎ ";
        format = "  [jl]($style) [($version )]($style)";
      };
      memory_usage = {
        symbol = "▪▫▪ ";
        format = "  mem [\${ram}( \${swap})]($style)";
      };
      nim = {
        symbol = "▴▲▴ ";
        format = "  [nim]($style) [($version )]($style)";
      };
      nix_shell = {
        symbol = "✶";
        format = "[$symbol nix⎪$state⎪]($style) [$name]($style)";
        impure_msg = "⌽";
        pure_msg = "⌾";
        unknown_msg = "◌";
      };
      spack = {
        symbol = "◇ ";
        format = " spack [$symbol$environment]($style)";
      };
    };
  };
}
