{ helpers, ... }:
{
  programs.nixvim = {
    plugins.inc-rename = {
      enable = true;
    };
    plugins.lsp.keymaps.extra = [
      {
        key = "<leader>cr";
        action = helpers.luaRawExpr ''
          return function()
            local inc_rename = require("inc_rename")
            return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
          end
        '';
        mode = [
          "n"
          "v"
        ];
        options = {
          desc = "Rename";
          expr = true;
        };
      }
    ];
  };
}
