{ ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings.mgr.show_hidden = true;

    keymap = {
      input.prepend_keymap = [
        {
          on = "<Esc>";
          run = "close";
          desc = "Cancel input";
        }
      ];
      mgr = {
        append_keymap = [ ];
        prepend_keymap = [
          {
            on = [
              "g"
              "r"
            ];
            run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
          }
        ];
      };
    };

    initLua = builtins.readFile ../../yazi/init.lua;
  };
}
