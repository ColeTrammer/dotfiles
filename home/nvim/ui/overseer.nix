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
    '';
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
        key = "<leader>tl";
        mode = "n";
        action = "<cmd>OverseerToggle<cr>";
        options.desc = "Task List";
      }
      {
        key = "<leader>tr";
        mode = "n";
        action = "<cmd>OverseerRun<cr>";
        options.desc = "Run Task";
      }
      {
        key = "<leader>tt";
        mode = "n";
        action = "<cmd>OverseerQuickAction<cr>";
        options.desc = "Task Action (Recent)";
      }
      {
        key = "<leader>ti";
        mode = "n";
        action = "<cmd>OverseerInfo<cr>";
        options.desc = "Overseer Info";
      }
      {
        key = "<leader>tn";
        mode = "n";
        action = "<cmd>OverseerBuild<cr>";
        options.desc = "New Task";
      }
      {
        key = "<leader>ta";
        mode = "n";
        action = "<cmd>OverseerTaskAction<cr>";
        options.desc = "Task Action";
      }
      {
        key = "<leader>tc";
        mode = "n";
        action = "<cmd>OverseerClearCache<cr>";
        options.desc = "Clear Cache";
      }
    ];
    plugins.which-key.registrations."<leader>t".name = "+task";
  };
}
