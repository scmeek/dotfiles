{ ... }:

{
  imports = [
    ../../home
    ../../darwin
    ../../profiles/development/darwin.nix
    ../../profiles/gpg/darwin.nix
    ../../profiles/notes/darwin.nix
    ./nvim
  ];

  home.stateVersion = "26.05";

  programs.git.settings.user.signingkey = "8F73E7B76CBD3188";

  programs.zsh.shellAliases.nrs = "nfmt && nix flake update && nix flake check && darwin-rebuild build --flake .#S-MBA && sudo darwin-rebuild switch --flake .#S-MBA B";

  dotfiles.opencode.providers = [
    "openai"
    "anthropic"
  ];
}
