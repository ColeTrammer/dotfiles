{ helpers, ... }:
{
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
      lazyLoad.settings = {
        cmd = [ "Neogit" ];
        keys = helpers.lazyKeyMaps [
          {
            key = "<leader>gg";
            action = helpers.luaRawExpr ''
              return function()
                local neogit = require("neogit")
                neogit.open()
              end
            '';
            mode = "n";
            options = {
              desc = "Git";
            };
          }
          {
            key = "<leader>gf";
            action = helpers.luaRawExpr ''
              return function()
                local file = vim.fn.expand("%")
                local neogit = require("neogit")
                neogit.action("log", "log_current", { "--", file })()
              end
            '';
            mode = "n";
            options = {
              desc = "Git Log (File)";
            };
          }
        ];
      };
    };
  };
}
