{
  programs.nixvim = {
    plugins.notify = {
      enable = true;
      timeout = 3000;
      stages = "fade";
      maxWidth = {
        __raw = ''
          function()
            return math.floor(vim.o.columns * 0.33)
          end
        '';
      };
      maxHeight = {
        __raw = ''
          function()
            return math.floor(vim.o.lines * 0.33)
          end
        '';
      };
    };
  };
}
