{
  programs.nixvim = {
    plugins.tmux-navigator = {
      enable = true;
      settings = {
        disable_when_zoomed = 1;
      };
    };
    keymaps = [
      {
        key = "<C-h>";
        mode = "t";
        action = "<cmd>TmuxNavigateLeft<cr>";
        options.desc = "Navigate Left";
      }
      {
        key = "<C-j>";
        mode = "t";
        action = "<cmd>TmuxNavigateDown<cr>";
        options.desc = "Navigate Down";
      }
      {
        key = "<C-k>";
        mode = "t";
        action = "<cmd>TmuxNavigateUp<cr>";
        options.desc = "Navigate Up";
      }
      {
        key = "<C-l>";
        mode = "t";
        action = "<cmd>TmuxNavigateRight<cr>";
        options.desc = "Navigate Right";
      }
      {
        key = "<C-\\>";
        mode = "t";
        action = "<cmd>TmuxNavigatePrevious<cr>";
        options.desc = "Navigate Previous";
      }
    ];
  };
}
