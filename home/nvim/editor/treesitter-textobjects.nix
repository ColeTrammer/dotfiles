{
  programs.nixvim = {
    plugins.treesitter-textobjects = {
      enable = true;
      move = {
        enable = true;
        setJumps = true;
        gotoNextStart = {
          "]f" = "@function.outer";
          "]]" = "@class.outer";
        };
        gotoNextEnd = {
          "]F" = "@function.outer";
          "][" = "@class.outer";
        };
        gotoPreviousStart = {
          "[f" = "@function.outer";
          "[[" = "@class.outer";
        };
        gotoPreviousEnd = {
          "[F" = "@function.outer";
          "[]" = "@class.outer";
        };
      };
      swap = {
        enable = true;
        swapNext = {
          "<leader>a" = "@parameter.inner";
        };
        swapPrevious = {
          "<leader>A" = "@parameter.inner";
        };
      };
    };
    plugins.treesitter = {
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "<C-space>";
          nodeIncremental = "<C-space>";
          nodeDecremental = "<bs>";
        };
      };
    };
  };
}
