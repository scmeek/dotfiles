{ ... }:

{
  programs.lazygit = {
    enable = true;
    enableZshIntegration = false;

    settings = {
      git = {
        overrideGpg = true;
        diffRenderers = [
          {
            colorArg = "always";
            command = "delta --dark --paging=never --syntax-theme base16-256 -s";
          }
        ];
      };
      gui = {
        nerdFontsVersion = "3";
        expandFocusedSidePanel = true;
      };
      os.edit = "nvim";
    };
  };
}
