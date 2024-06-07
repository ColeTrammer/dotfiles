{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      overseer-nvim
    ];
    extraConfigLua = ''
      require("overseer").setup({
        strategy = "toggleterm",
        task_list = {
          bindings = {
            ["<C-h>"] = false,
            ["<C-j>"] = false,
            ["<C-k>"] = false,
            ["<C-l>"] = false,
          },
        },
        form = {
          win_opts = {
            winblend = 0,
          },
        },
        confirm = {
          win_opts = {
            winblend = 0,
          },
        },
        task_win = {
          win_opts = {
            winblend = 0,
          },
        },
      })

      -- Restart last task recipe
      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    '';
    plugins.neotest = {
      settings = {
        consumers.overseer.__raw = ''require("neotest.consumers.overseer")'';
        overseer = {
          enabled = true;
        };
      };
    };
    plugins.lualine.sections.lualine_x = lib.mkOrder 1000 [
      {
        name = "overseer";
        extraConfig = {
          symbols = {
            "CANCELED" = " ";
            "FAILURE" = " ";
            "SUCCESS" = " ";
            "RUNNING" = " ";
          };
        };
      }
    ];
    keymaps = [
      {
        key = "<leader>ol";
        mode = "n";
        action = "<cmd>OverseerToggle<cr>";
        options.desc = "Task List";
      }
      {
        key = "<leader>or";
        mode = "n";
        action = "<cmd>OverseerRun<cr>";
        options.desc = "Run Task";
      }
      {
        key = "<leader>ot";
        mode = "n";
        action = "<cmd>OverseerQuickAction<cr>";
        options.desc = "Task Action (Recent)";
      }
      {
        key = "<leader>oi";
        mode = "n";
        action = "<cmd>OverseerInfo<cr>";
        options.desc = "Overseer Info";
      }
      {
        key = "<leader>on";
        mode = "n";
        action = "<cmd>OverseerBuild<cr>";
        options.desc = "New Task";
      }
      {
        key = "<leader>oa";
        mode = "n";
        action = "<cmd>OverseerTaskAction<cr>";
        options.desc = "Task Action";
      }
      {
        key = "<leader>oc";
        mode = "n";
        action = "<cmd>OverseerClearCache<cr>";
        options.desc = "Clear Cache";
      }
      {
        key = "<leader>oo";
        mode = "n";
        action = "<cmd>OverseerRestartLast<cr>";
        options.desc = "Restart Last Task";
      }
    ];
    plugins.which-key.registrations."<leader>o".name = "+task";
  };
}
