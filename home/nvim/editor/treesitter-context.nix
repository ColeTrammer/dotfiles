{
  programs.nixvim = {
    plugins.treesitter-context = {
      enable = true;
      settings = {
        mode = "cursor";
        max_lines = 3;
      };
    };
  };
}
