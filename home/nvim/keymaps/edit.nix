{
  programs.nixvim = {
    keymaps = [
      {
        mode = ["n"];
        key = "<leader>r";
        action.__raw = ''[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]'';
        options = {
          desc = "Replace Word Under Cursor";
        };
      }
      # Move Lines
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>m .+1<cr>==";
        options = {
          desc = "Move Down";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>m .-2<cr>==";
        options = {
          desc = "Move Up";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options = {
          desc = "Move Down";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options = {
          desc = "Move Up";
          silent = true;
        };
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<cr>gv=gv";
        options = {
          desc = "Move Down";
          silent = true;
        };
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<cr>gv=gv";
        options = {
          desc = "Move Up";
          silent = true;
        };
      }
    ];
  };
}
