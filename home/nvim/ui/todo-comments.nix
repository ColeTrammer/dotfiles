{
  programs.nixvim = {
    plugins.todo-comments = {enable = true;};
    keymaps = [
      {
        mode = "n";
        key = "<leader>xt";
        action = "<cmd>Trouble todo toggle<cr>";
        options = {
          desc = "Todo (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xT";
        action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
        options = {
          desc = "Todo Filtered (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>sx";
        action = "<cmd>TodoTelescope<cr>";
        options = {
          desc = "Todo";
        };
      }
      {
        mode = "n";
        key = "<leader>sX";
        action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
        options = {
          desc = "Todo Filtered";
        };
      }
      {
        mode = "n";
        key = "]t";
        action.__raw = ''
          function()
            require("todo-comments").jump_next()
          end
        '';
        options = {
          desc = "Next Todo";
        };
      }
      {
        mode = "n";
        key = "[t";
        action.__raw = ''
          function()
            require("todo-comments").jump_prev()
          end
        '';
        options = {
          desc = "Prev Todo";
        };
      }
    ];
  };
}
