{ helpers, ... }:
{
  programs.nixvim = {
    plugins.yanky = {
      enable = true;
      lazyLoad.settings = {
        keys = helpers.lazyKeyMaps [
          {
            key = "<leader>p";
            action = "YankyRingHistory";
            mode = "n";
            options = {
              desc = "Yank History";
            };
          }
          {
            key = "y";
            action = "<Plug>(YankyYank)";
            mode = [
              "n"
              "x"
            ];
            options = {
              desc = "Yank Text";
            };
          }
          {
            key = "p";
            action = "<Plug>(YankyPutAfter)";
            mode = [
              "n"
              "x"
            ];
            options = {
              desc = "Put After Cursor";
            };
          }
          {
            key = "P";
            action = "<Plug>(YankyPutBefore)";
            mode = [
              "n"
              "x"
            ];
            options = {
              desc = "Put Before Cursor";
            };
          }
          {
            key = "gp";
            action = "<Plug>(YankyGPutAfter)";
            mode = [
              "n"
              "x"
            ];
            options = {
              desc = "Put After Selection";
            };
          }
          {
            key = "gP";
            action = "<Plug>(YankyGPutBefore)";
            mode = [
              "n"
              "x"
            ];
            options = {
              desc = "Put Before Selection";
            };
          }
          {
            key = "<c-p>";
            action = "<Plug>(YankyPreviousEntry)";
            mode = "n";
            options = {
              desc = "Cycle Put To Previous Entry";
            };
          }
          {
            key = "<c-n>";
            action = "<Plug>(YankyNextEntry)";
            mode = "n";
            options = {
              desc = "Cycle Put To Next Entry";
            };
          }
          {
            key = "]p";
            action = "<Plug>(YankyPutIndentAfterLinewise)";
            mode = "n";
            options = {
              desc = "Put After Cursor Line";
            };
          }
          {
            key = "[p";
            action = "<Plug>(YankyPutIndentBeforeLinewise)";
            mode = "n";
            options = {
              desc = "Put Before Cursor Line";
            };
          }
          {
            key = "]P";
            action = "<Plug>(YankyPutIndentAfterLinewise)";
            mode = "n";
            options = {
              desc = "Put After Cursor Line";
            };
          }
          {
            key = "[P";
            action = "<Plug>(YankyPutIndentBeforeLinewise)";
            mode = "n";
            options = {
              desc = "Put Before Cursor Line";
            };
          }
          {
            key = "=p";
            action = "<Plug>(YankyPutAfterFilter)";
            mode = "n";
            options = {
              desc = "Put After Filter";
            };
          }
          {
            key = "=P";
            action = "<Plug>(YankyPutBeforeFilter)";
            mode = "n";
            options = {
              desc = "Put Before Filter";
            };
          }
        ];
      };
      settings = {
        ring = {
          storage = "shada";
          historyLength = 1000;
        };
        highlight.timer = 200;
      };
    };
  };
}
