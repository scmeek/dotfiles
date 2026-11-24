{ lib, ... }:

let
  eksAliases = lib.listToAttrs (
    map
      (
        { cluster, stage }:
        lib.nameValuePair "k8s-${cluster}-${stage}" "aws eks --region us-gov-west-1 update-kubeconfig --name ${cluster}-${stage} --profile ${cluster}-${stage}-iac-admin"
      )
      (
        lib.cartesianProduct {
          cluster = [
            "apsr"
            "common"
            "infra"
            "lexi"
          ];
          stage = [
            "dev"
            "stage"
            "prod"
          ];
        }
      )
  );
in
{
  programs.zsh = {
    shellAliases = {
      acr = "az acr login --name asusdev";
      open = "explorer.exe";
      nrs = "nfmt && nix flake update && nix flake check && home-manager build --flake .#sean@ASUS-2D03N64 && home-manager switch --flake .#sean@ASUS-2D03N64 B";
      sf = "source frigg_bashrc";
      sff = "source frigg_bashrc force";
      tf = "tofu";
      tg = "terragrunt";

      aws-apsr-dev = "export AWS_PROFILE=apsr-dev-gov-admin && aws sso login";
      aws-apsr-stage = "export AWS_PROFILE=apsr-stage-gov-admin && aws sso login";
      aws-apsr-prod = "export AWS_PROFILE=apsr-prod-gov-admin && aws sso login";
      aws-infra-prod = "export AWS_PROFILE=infra-prod-gov-admin && aws sso login";

      # Windows drops Zone.Identifier streams as files on the WSL filesystem.
      showzoneidfiles = "find . -type f -name '*:Zone.Identifier' -print";
      rmzoneidfiles = "find . -type f -name '*:Zone.Identifier' -delete";
    }
    // eksAliases;

    initContent = lib.mkAfter ''
      # https://openproject.astroscale-us.com/projects/software-team/wiki/iac-local-development
      export TG_TF_FORWARD_STDOUT=true
      export TENV_AUTO_INSTALL=true

      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init - zsh)"

      declare -a additional_env_paths=("./python3_frigg")

      . "/home/sean/.local/share/cargo/env"

      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C /usr/bin/terraform terraform

      eval "$(pixi completion --shell zsh)"
    '';
  };
}
