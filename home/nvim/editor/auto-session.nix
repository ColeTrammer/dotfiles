{
  config,
  lib,
  helpers,
  ...
}:
{
  options = {
    nvim.auto-session = {
      preSaveCmds = lib.mkOption {
        type = with lib.types; listOf anything;
        default = [ ];
      };
      preRestoreCmds = lib.mkOption {
        type = with lib.types; listOf anything;
        default = [ ];
      };
      postRestoreCmds = lib.mkOption {
        type = with lib.types; listOf anything;
        default = [ ];
      };
    };
  };

  config = {
    programs.nixvim = {
      plugins.auto-session = {
        enable = true;
        lazyLoad.settings.lazy = false;
        settings = {
          log_level = "error";
          bypass_save_filetypes = [
            "gitcommit"
            "alpha"
            "oil"
            "NeogitStatus"
          ];
          use_git_branch = true;
          auto_restore = true;
          show_auto_restore_notif = false;
          supressed_dirs = [
            "${config.home.homeDirectory}"
            "${config.preferences.workspacePath}"
            "/"
          ];
          pre_save_cmds = config.nvim.auto-session.preSaveCmds;
          pre_restore_cmds = config.nvim.auto-session.preRestoreCmds;
          post_restore_cmds = config.nvim.auto-session.postRestoreCmds ++ [
            (helpers.luaRawExpr ''
              return function()
                vim.cmd("stopinsert")
              end
            '')
          ];
        };
      };
      # Save the session every 5 minutes.
      extraConfigLua = ''
        local session_autosave_timer = assert(vim.uv.new_timer())
        session_autosave_timer:start(
          5 * 60 * 1000,
          5 * 60 * 1000,
          vim.schedule_wrap(function()
            vim.cmd("SessionSave")
          end)
        )
      '';
      keymaps = [
        {
          mode = "n";
          key = "<leader>qs";
          action = "<cmd>SessionSave<cr>";
          options.desc = "Save Session";
        }
        {
          mode = "n";
          key = "<leader>qr";
          action = "<cmd>SessionRestore<cr>";
          options.desc = "Restore Session";
        }
        {
          mode = "n";
          key = "<leader>qd";
          action = "<cmd>SessionDelete<cr>";
          options.desc = "Restore Session";
        }
        {
          mode = "n";
          key = "<leader>sq";
          action = helpers.luaRawExpr ''
            return function()
              require("auto-session.session-lens").search_session()
            end
          '';
          options.desc = "Sessions";
        }
      ];
    };
  };
}
