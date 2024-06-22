{ config, helpers, ... }:
{
  programs.nixvim = {
    plugins.auto-session = {
      enable = true;
      logLevel = "error";
      bypassSessionSaveFileTypes = [
        "gitcommit"
        "alpha"
      ];
      autoRestore.enabled = false;
      autoSession = {
        suppressDirs = [
          "~/"
          "~/Projects"
          "~/${config.preferences.workspacePath}"
          "/"
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
}
