{ lib, ... }:

{
  home.sessionPath = [
    # "<additional environment bin directory>"
  ];

  programs.zsh = {
    shellAliases = {
      # Add ASUS aliases here; use lib.mkForce when replacing a shared alias.
      # example = "<command>";
    };

    initContent = lib.mkAfter ''
      # Fill in and uncomment the four ASUS exports.
      # export ENV_NAME_1="<value>"
      # export ENV_NAME_2="<value>"
      # export ENV_NAME_3="<value>"
      # export ENV_NAME_4="<value>"

      # Conditional PATH update.
      # if <test command>; then
      #   export PATH="<directory>:$PATH"
      # fi

      # Additional shell initialization.
      # eval "$(<initialization command>)"

      # Cargo's environment file is optional; CARGO_HOME comes from the development profile.
      if [[ -f "$CARGO_HOME/env" ]]; then
        source "$CARGO_HOME/env"
      fi

      if command -v terraform >/dev/null 2>&1; then
        autoload -Uz bashcompinit
        bashcompinit
        complete -o nospace -C "$(command -v terraform)" terraform
      fi

      if command -v pixi >/dev/null 2>&1; then
        eval "$(pixi completion --shell zsh)"
      fi
    '';
  };
}
