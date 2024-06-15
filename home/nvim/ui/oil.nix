{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        use_default_keymaps = false;
        skip_confirm_for_simple_edits = true;
        view_options = {
          show_hidden = true;
          is_always_hidden = ''
            function(name, bufnr)
              return name == ".." or name == ".git"
            end
          '';
        };
        # Keymaps are redone to avoid conflicting with window navigation via tmux.
        keymaps = {
          "g?" = "actions.show_help";
          "<CR>" = "actions.select";
          "<C-]>" = "actions.select_split";
          "<C-^>" = "actions.select_vsplit";
          "<C-t>" = "actions.select_tab";
          "<C-p>" = "actions.preview";
          "<C-c>" = "actions.close";
          "<C-r>" = "actions.refresh";
          "-" = "actions.parent";
          "_" = "actions.open_cwd";
          "`" = "actions.cd";
          "~" = "actions.tcd";
          "gs" = "actions.change_sort";
          "gx" = "actions.open_external";
          "g." = "actions.toggle_hidden";
          "gd" = {
            __raw = ''
              {
                desc = "Toggle File Detail View",
                callback = function()
                  detail = not detail
                  if detail then
                    require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                  else
                    require("oil").set_columns({ "icon" })
                  end
                end,
              }
            '';
          };
          "g\\" = "actions.toggle_trash";
          "q" = "actions.close";
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<cmd>Oil<cr>";
        options = {
          desc = "Open Parent Directory";
          remap = true;
        };
      }
    ];
  };
}
