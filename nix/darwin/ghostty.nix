{ ... }:

{
  homebrew.casks = [
    {
      name = "ghostty@tip";
      greedy = true;
    }
  ];

  home-manager.sharedModules = [
    {
      programs.ghostty = {
        enable = true;
        package = null;
        settings = {
          shell-integration-features = "ssh-env,ssh-terminfo";
        };
      };
    }
  ];
}
