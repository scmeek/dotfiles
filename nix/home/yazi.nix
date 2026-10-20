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

    initLua = ''
      -- Show symlink in status bar
      -- https://yazi-rs.github.io/docs/tips/#symlink-in-status
      Status:children_add(function(self)
        local h = self._current.hovered
        if h and h.link_to then
          return " -> " .. tostring(h.link_to)
        else
          return ""
        end
      end, 3300, Status.LEFT)

      -- Show user/group of files in status bar
      -- https://yazi-rs.github.io/docs/tips/#user-group-in-status
      Status:children_add(function()
        local h = cx.active.current.hovered
        if not h or ya.target_family() ~= "unix" then
          return ""
        end

        return ui.Line({
          ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
          ":",
          ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
          " ",
        })
      end, 500, Status.RIGHT)
    '';
  };
}
