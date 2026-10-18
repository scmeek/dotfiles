{ pkgs, ... }:

{
  imports = [ ./gpg.nix ];

  home.packages = [
    pkgs.pinentry_mac
  ];

  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac

    default-cache-ttl 600
    max-cache-ttl 7200
    default-cache-ttl-ssh 600
    max-cache-ttl-ssh 7200
  '';
}
