{
  programs.nixvim = {
    plugins.treesitter-context = {
      enable = true;
      settings = {
        mode = "cursor";
        max_lines = 3;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>TSContextToggle<cr>";
        options = {
          desc = "Toggle Treesitter Context";
        };
      }
    ];
  };
}
