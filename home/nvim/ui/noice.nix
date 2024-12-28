{ helpers, lib, ... }:
{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
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
                { find = "%d+L, %d+B"; }
                { find = "; after #%d+"; }
                { find = "; before #%d+"; }
                { find = "%d+ lines"; }
                { find = "%d+ fewer lines"; }
                { find = "Hunk %d+ of %d+"; }
                { find = "Saved session: %s"; }
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
    };
    plugins.lualine.settings.sections.lualine_x = lib.mkOrder 800 [
      {
        __raw = ''
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
          }
        '';
      }
      {
        __raw = ''
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
          }
        '';
      }
    ];
    keymaps = [
      {
        key = "<leader>snl";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("noice").cmd("last")
          end
        '';
        options.desc = "Noice Last Message";
      }
      {
        key = "<leader>snh";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("noice").cmd("history")
          end
        '';
        options.desc = "Noice History";
      }
      {
        key = "<leader>sna";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("noice").cmd("all")
          end
        '';
        options.desc = "Noice All";
      }
      {
        key = "<leader>snd";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("noice").cmd("dismiss")
          end
        '';
        options.desc = "Dismiss All";
      }
      {
        key = "<leader>snt";
        mode = "n";
        action = helpers.luaRawExpr ''
          return function()
            require("noice").cmd("pick")
          end
        '';
        options.desc = "Noice Picker (Telescope/FzfLua)";
      }
      {
        key = "<c-f>";
        mode = [
          "i"
          "n"
          "s"
        ];
        action = helpers.luaRawExpr ''
          return function()
            if not require("noice.lsp").scroll(4) then
              return "<c-f>"
            end
          end
        '';
        options.desc = "Scroll Forward";
        options.silent = true;
        options.expr = true;
      }
      {
        key = "<c-b>";
        mode = [
          "i"
          "n"
          "s"
        ];
        action = helpers.luaRawExpr ''
          return function()
            if not require("noice.lsp").scroll(-4) then
              return "<c-b>"
            end
          end
        '';
        options.desc = "Scroll Backward";
        options.silent = true;
        options.expr = true;
      }
    ];
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>sn";
        group = "+notifications";
      }
    ];
  };
}
