{
  config,
  lib,
  ...
}:
{
  options = {
    nvim.neorg = {
      workspaces = lib.mkOption {
        type = with lib.types; attrsOf str;
        default = {
          notes = "~/Workspace/notes";
        };
        description = "Neorg workspaces";
      };
      defaultWorkspace = lib.mkOption {
        type = with lib.types; str;
        default = "notes";
        description = "Neorg default workspace";
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.neorg = {
        enable = true;
        lazyLoad.settings = {
          cmd = "Neorg";
          ft = "norg";
        };
        settings = {
          load = {
            "core.defaults" = {
              __empty = null;
            };
            "core.concealer" = {
              __empty = null;
            };
            "core.dirman" = {
              config = {
                workspaces = config.nvim.neorg.workspaces;
                default_workspace = config.nvim.neorg.defaultWorkspace;
              };
            };
            "core.export.markdown" = {
              __empty = null;
            };
            "core.keybinds" = {
              config = {
                neorg_leader = "<leader>n";
              };
            };
          };
        };
      };
      plugins.which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>n";
          group = "+neorg";
        }
      ];
    };

    nvim.otter.langs = [ "norg" ];
  };
}
