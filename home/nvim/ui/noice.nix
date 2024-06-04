{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              {find = "%d+L, %d+B";}
              {find = "; after #%d+";}
              {find = "; before #%d+";}
              {find = "%d+ lines";}
              {find = "%d+ fewer lines";}
              {find = "Hunk %d+ of %d+";}
            ];
          };
          view = "mini";
        }
      ];
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        lsp_doc_border = true;
      };
    };
    plugins.lualine.sections.lualine_x = [
      {
        extraConfig.__raw = ''
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
          }
        '';
      }
      {
        extraConfig.__raw = ''
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
          }
        '';
      }
    ];
  };
}
