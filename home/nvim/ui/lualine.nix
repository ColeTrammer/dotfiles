{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      globalstatus = true;
      disabledFiletypes.statusline = [ "alpha" ];
      componentSeparators = {
        left = "|";
        right = "|";
      };
      sectionSeparators = {
        left = "";
        right = "";
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [
          {
            name = "branch";
            icon = "";
          }
          {
            name = "diff";
            extraConfig.symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
            extraConfig.source.__raw = ''
              function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end
            '';
          }
        ];
        lualine_c = [
          {
            name = "diagnostics";
            extraConfig.symbols = {
              error = " ";
              warn = " ";
              hint = " ";
              info = " ";
            };
          }
          {
            name = "filetype";
            extraConfig.icon_only = true;
            padding.left = 1;
            padding.right = 0;
            extraConfig.separator = "";
          }
          {
            name = "filename";
            padding.left = 0;
            padding.right = 1;
          }
        ];
        lualine_x = [ ];
        lualine_y = [
          "encoding"
          "fileformat"
        ];
        lualine_z = [
          {
            name = "progress";
            padding.left = 1;
            padding.right = 0;
            extraConfig.separator = " ";
          }
          {
            name = "location";
            padding.left = 0;
            padding.right = 1;
          }
        ];
      };
    };
  };
}
