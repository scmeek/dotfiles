{ lib, ... }:

{
  home.sessionPath = [
    # "<additional environment bin directory>"
  ];

  programs.zsh = {
    shellAliases = {
      acr = "az acr login --name asusdev";
      open = "explorer.exe";
      hrs = "nix flake update && home-manager build --flake .#sean@ASUS-2D03N64 && home-manager switch --flake .#sean@ASUS-2D03N64";
      sf = "source frigg_bashrc";
      sff = "source frigg_bashrc force";
      tf = "tofu";
      tg = "terragrunt";

      # AWS LOGIN
      aws-apsr-dev = "export AWS_PROFILE=apsr-dev-gov-admin && aws sso login";
      aws-apsr-stage = "export AWS_PROFILE=apsr-stage-gov-admin && aws sso login";
      aws-apsr-prod = "export AWS_PROFILE=apsr-prod-gov-admin && aws sso login";
      aws-infra-prod = "export AWS_PROFILE=infra-prod-gov-admin && aws sso login";

      # KUBERENETES CLUSTERS LOGIN
      k8s-infra-dev = "aws eks --region us-gov-west-1 update-kubeconfig --name infra-dev --profile infra-dev-iac-admin";
      k8s-infra-stage = "aws eks --region us-gov-west-1 update-kubeconfig --name infra-stage --profile infra-stage-iac-admin";
      k8s-infra-prod = "aws eks --region us-gov-west-1 update-kubeconfig --name infra-prod --profile infra-prod-iac-admin";
      k8s-common-dev = "aws eks --region us-gov-west-1 update-kubeconfig --name common-dev --profile common-dev-iac-admin";
      k8s-common-stage = "aws eks --region us-gov-west-1 update-kubeconfig --name common-stage --profile common-stage-iac-admin";
      k8s-common-prod = "aws eks --region us-gov-west-1 update-kubeconfig --name common-prod --profile common-prod-iac-admin";
      k8s-apsr-dev = "aws eks --region us-gov-west-1 update-kubeconfig --name apsr-dev --profile apsr-dev-iac-admin";
      k8s-apsr-stage = "aws eks --region us-gov-west-1 update-kubeconfig --name apsr-stage --profile apsr-stage-iac-admin";
      k8s-apsr-prod = "aws eks --region us-gov-west-1 update-kubeconfig --name apsr-prod --profile apsr-prod-iac-admin";
      k8s-lexi-dev = "aws eks --region us-gov-west-1 update-kubeconfig --name lexi-dev --profile lexi-dev-iac-admin";
      k8s-lexi-stage = "aws eks --region us-gov-west-1 update-kubeconfig --name lexi-stage --profile lexi-stage-iac-admin";
      k8s-lexi-prod = "aws eks --region us-gov-west-1 update-kubeconfig --name lexi-prod --profile lexi-prod-iac-admin";

      # Windows WSL convenience
      showzoneidfiles = "find . -type f -name '*:Zone.Identifier' -print";
      rmzoneidfiles = "find . -type f -name '*:Zone.Identifier' -delete";
    };

    initContent = lib.mkAfter ''
      # apsr-prod-gov-admin
      # export AWS_PROFILE=sso-admin-east

      # https://openproject.astroscale-us.com/projects/software-team/wiki/iac-local-development
      export TG_TF_FORWARD_STDOUT=true
      # https://openproject.astroscale-us.com/projects/software-team/wiki/iac-local-development
      export TENV_AUTO_INSTALL=true

      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init - zsh)"

      declare -a additional_env_paths=("./python3_frigg")

      # Configure shell to env file
      . "/home/sean/.local/share/cargo/env"

      # Terraform autocompletion
      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C /usr/bin/terraform terraform

      # Pixi autocompletion
      eval "$(pixi completion --shell zsh)"
    '';
  };
}
