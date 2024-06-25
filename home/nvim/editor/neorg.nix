{
  config,
  inputs,
  lib,
  ...
}:
{
  options = {
    nvim.neorg = {
      workspaces = lib.mkOption {
        type = with lib.types; attrsOf string;
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
    nixpkgs.overlays = [ inputs.neorg-overlay.overlays.default ];
    programs.nixvim = {
      plugins.neorg = {
        enable = true;
        modules = {
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
          "core.completion" = {
            config = {
              engine = "nvim-cmp";
            };
          };
          "core.integrations.nvim-cmp" = {
            __empty = null;
          };
          "core.integrations.telescope" = {
            __empty = null;
          };
          "core.keybinds" = {
            config = {
              neorg_leader = "<leader>n";
            };
          };
        };
      };
      plugins.cmp.settings.sources = [ { name = "neorg"; } ];
      plugins.which-key.registrations."<leader>n".name = "+neorg";
    };

    nvim.otter.langs = [ "norg" ];
  };
}
