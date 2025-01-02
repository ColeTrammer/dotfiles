{
  config,
  helpers,
  inputs,
  lib,
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

  config = {
    programs.nixvim = {
      plugins.otter = {
        enable = true;
        autoActivate = false;
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
              local languages = ${helpers.nixvim.toLuaObject config.nvim.otter.allLangs}
              otter.activate(languages, true, true, nil)
            end
          '';
        }
      ];
    };
  };
}
