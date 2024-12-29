{ helpers, ... }:
{
  programs.nixvim = {
    plugins.refactoring = {
      enable = true;
      lazyLoad.settings = {
        cmd = "Refactor";
        keys = helpers.lazyKeyMaps [
          {
            mode = "v";
            key = "<leader>rs";
            action = helpers.luaRawExpr ''
              return function()
                require("telescope").extensions.refactoring.refactors()
              end'';
            options.desc = "Refactor";
          }
          {
            mode = [
              "n"
              "v"
            ];
            key = "<leader>ri";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").refactor("Inline Variable")
              end'';
            options.desc = "Inline Variable";
          }
          {
            mode = "n";
            key = "<leader>rb";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").refactor("Extract Block")
              end'';
            options.desc = "Extract Block";
          }
          {
            mode = "n";
            key = "<leader>rf";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").refactor("Extract Block To File")
              end'';
            options.desc = "Extract Block To File";
          }
          {
            mode = "n";
            key = "<leader>rP";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").debug.printf({ below = false })
              end'';
            options.desc = "Debug Print";
          }
          {
            mode = "n";
            key = "<leader>rp";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").debug.print_var({ normal = true })
              end'';
            options.desc = "Debug Print Variable";
          }
          {
            mode = "n";
            key = "<leader>rc";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").debug.cleanup({})
              end'';
            options.desc = "Debug Cleanup";
          }
          {
            mode = "v";
            key = "<leader>rf";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").refactor("Extract Function")
              end'';
            options.desc = "Extract Function";
          }
          {
            mode = "v";
            key = "<leader>rF";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").refactor("Extract Function To File")
              end'';
            options.desc = "Extract Function To File";
          }
          {
            mode = "v";
            key = "<leader>rx";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").refactor("Extract Variable")
              end'';
            options.desc = "Extract Variable";
          }
          {
            mode = "v";
            key = "<leader>rp";
            action = helpers.luaRawExpr ''
              return function()
                require("refactoring").debug.print_var()
              end'';
            options.desc = "Debug Print Variable";
          }
        ];
      };
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>r";
        group = "+refactor";
      }
    ];
  };
}
