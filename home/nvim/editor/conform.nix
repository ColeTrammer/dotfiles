{ helpers, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      notifyOnError = true;
      formattersByFt."_" = [ "trim_whitespace" ];
      formatters.injected.options.ignore_errors = true;
    };
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>cF";
        action = helpers.luaRawExpr ''
          return function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        options.desc = "Format Injected Languages";
      }
    ];
    extraConfigLua = ''
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    '';
  };
}
