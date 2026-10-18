{ ... }:

{
  programs.halloy = {
    enable = true;

    settings.servers.liberachat = {
      nickname = "timid_taste";
      server = "irc.libera.chat";
      port = 6697;
      use_tls = true;
      channels = [ "#halloy" ];
    };
  };
}
