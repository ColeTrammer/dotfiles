{ helpers, ... }:
{
  programs.nixvim = {
    plugins.neotest = {
      enable = true;
      settings = {
        status = {
          virtual_text = true;
        };
        output = {
          open_on_run = true;
        };
      };
      lazyLoad.settings = {
        cmd = "Neotest";
        keys = helpers.lazyKeyMaps [
          {
            key = "<leader>tt";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").run.run(vim.fn.expand("%"))
              end
            '';
            options.desc = "Run File";
          }
          {
            key = "<leader>tT";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").run.run(vim.uv.cwd())
              end
            '';
            options.desc = "Run All Test Files";
          }
          {
            key = "<leader>tr";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").run.run()
              end
            '';
            options.desc = "Run Nearest";
          }
          {
            key = "<leader>tl";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").run.run_last()
              end
            '';
            options.desc = "Run Last";
          }
          {
            key = "<leader>ts";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").summary.toggle()
              end
            '';
            options.desc = "Toggle Summary";
          }
          {
            key = "<leader>to";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").output.open({ enter = true, auto_close = true })
              end
            '';
            options.desc = "Show Output";
          }
          {
            key = "<leader>tO";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").output_panel.toggle()
              end
            '';
            options.desc = "Toggle Output Panel";
          }
          {
            key = "<leader>tS";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").run.stop()
              end
            '';
            options.desc = "Stop";
          }
          {
            key = "<leader>tw";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").watch.toggle(vim.fn.expand("%"))
              end
            '';
            options.desc = "Toggle Watch";
          }
          {
            key = "<leader>td";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("neotest").run.run({ strategy = "dap" })
              end
            '';
            options.desc = "Debug Nearest";
          }
        ];
      };
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>t";
        group = "+test";
      }
    ];
  };
}
