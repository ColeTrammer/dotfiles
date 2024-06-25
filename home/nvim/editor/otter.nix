{
  config,
  helpers,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    nvim.otter = {
      langs = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
        description = ''Langugages with embedded Langugages.'';
      };
      allLangs = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
        description = ''Langugages to look for.'';
      };
    };
  };

  config =
    let
      nixvimHelpers = inputs.nixvim.lib.${pkgs.system}.helpers;
    in
    {
      programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [ otter-nvim ];
        extraConfigLua = ''
          local otter = require("otter")
          otter.setup({
            handle_leading_whitespace = true,
          })
        '';
        plugins.cmp.settings.sources = [ { name = "otter"; } ];

        autoGroups.otter.clear = true;
        autoCmd = [
          {
            event = [ "FileType" ];
            pattern = config.nvim.otter.langs;
            callback = helpers.luaRawExpr ''
              return function()
                local otter = require("otter")
                local languages = ${nixvimHelpers.toLuaObject config.nvim.otter.allLangs}
                otter.activate(languages, true, true, nil)

                -- TODO: remove these custom keybindings once this is no longer needed (otter is a regular LSP).
                vim.keymap.set("n", "gd", function()
                  otter.ask_definition()
                end, { desc = "Goto Definition" })
                vim.keymap.set("n", "gy", function()
                  otter.ask_type_definition()
                end, { desc = "Goto T[y]pe Definition" })
                vim.keymap.set("n", "K", function()
                  otter.ask_hover()
                end, { desc = "Hover" })
                vim.keymap.set("n", "gr", function()
                  otter.ask_references()
                end, { desc = "Goto References" })
                vim.keymap.set("n", "cr", function()
                  otter.ask_rename()
                end, { desc = "Rename" })
              end
            '';
          }
        ];
      };
    };
}
