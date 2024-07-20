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
        plugins.otter = {
          enable = true;
          settings = {
            handle_leading_whitespace = true;
          };
        };

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
              end
            '';
          }
        ];
      };
    };
}
