{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      modules = {
        indentscope = {
          symbol = "│";
          options = {
            try_as_border = true;
          };
        };
        surround = {
          mappings = {
            add = "gsa";
            delete = "gsd";
            find = "gsf";
            find_left = "gsF";
            highlight = "gsh";
            replace = "gsr";
            update_n_lines = "gsn";
          };
        };
        ai = {
          __raw = ''
            (function()
              local ai = require("mini.ai")
              return {
                n_lines = 500,
                custom_textobjects = {
                  o = ai.gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                  }, {}),
                  f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                  c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                  d = { "%f[%d]%d+" }, -- Digits
                  e = { -- Word (minus camel/snake case)
                    {
                      "%u[%l%d]+%f[^%l%d]",
                      "%f[%S][%l%d]+%f[^%l%d]",
                      "%f[%P][%l%d]+%f[^%l%d]",
                      "^[%l%d]+%f[^%l%d]",
                    },
                    "^().*()$",
                  },
                  g = function() -- Whole buffer
                    local from = { line = 1, col = 1 }
                    local to = {
                      line = vim.fn.line('$'),
                      col = math.max(vim.fn.getline('$'):len(), 1)
                    }
                    return { from = from, to = to, vis_mode = 'V' }
                  end,
                  u = ai.gen_spec.function_call(), -- Function call
                },
              }
            end)()
          '';
        };
      };
    };
    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [
          "help"
          "alpha"
          "dashboard"
          "neo-tree"
          "Trouble"
          "trouble"
          "lazy"
          "mason"
          "notify"
          "toggleterm"
          "lazyterm"
        ];
        callback.__raw = ''
          function()
            vim.b.miniindentscope_disable = true
          end
        '';
      }
    ];
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "gs";
        group = "+surround";
      }
    ];
  };
}
