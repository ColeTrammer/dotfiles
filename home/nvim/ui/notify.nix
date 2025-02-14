{ helpers, ... }:
{
  programs.nixvim = {
    plugins.notify = {
      enable = true;
      settings = {
        timeout = 3000;
        stages = "fade";
        maxWidth = helpers.luaRawExpr ''
          return function()
            return math.floor(vim.o.columns * 0.33)
          end
        '';
        maxHeight = helpers.luaRawExpr ''
          return function()
            return math.floor(vim.o.lines * 0.33)
          end
        '';
      };
    };
  };
}
