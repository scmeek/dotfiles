{ config, lib, ... }:

{
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    # Keep existing gpg.conf unmanaged instead of installing the module's default settings.
    settings = lib.mkForce { };
  };

  programs.git.settings.commit.gpgsign = true;

  programs.zsh.initContent = ''
    if [[ -t 1 ]]; then
      export GPG_TTY="$(tty)"
    fi
  '';
}
