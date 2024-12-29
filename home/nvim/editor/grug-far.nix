{
  helpers,
  inputs,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins.grug-far = {
      enable = true;
      lazyLoad.settings = {
        cmd = "GrugFar";
        keys = helpers.lazyKeyMaps [
          {
            key = "<leader>sr";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("grug-far").open({
                  transient = true,
                })
              end
            '';
            options.desc = "Search and Replace (Grug Far)";
          }
          {
            key = "<leader>sp";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("grug-far").open({
                  transient = true,
                  prefills = { paths = vim.fn.expand("%") },
                })
              end
            '';
            options.desc = "Search current file (Grug Far)";
          }
          {
            key = "<leader>sw";
            mode = "n";
            action = helpers.luaRawExpr ''
              return function()
                require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
              end
            '';
            options.desc = "Search current word (Grug Far)";
          }
          {
            key = "<leader>sw";
            mode = "v";
            action = helpers.luaRawExpr ''
              return function()
                require("grug-far").with_visual_selection({})
              end
            '';
            options.desc = "Search current word (Grug Far)";
          }
        ];
      };
      settings = {
        headerMaxWidth = 80;
      };
    };
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "grug-far";
        src = inputs.grug-far;
      })
    ];
  };
}
