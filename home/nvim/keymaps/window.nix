{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>ww";
        action = "<C-W>p";
        options = {
          desc = "Other Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wd";
        action = "<C-W>c";
        options = {
          desc = "Delete Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>w-";
        action = "<C-W>s";
        options = {
          desc = "Split Window Below";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>w|";
        action = "<C-W>v";
        options = {
          desc = "Split Window Right";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<C-W>s";
        options = {
          desc = "Split Window Below";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>|";
        action = "<C-W>v";
        options = {
          desc = "Split Window Right";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wk";
        action = "<cmd>resize +4<cr>";
        options = {
          desc = "Increase Window Height";
        };
      }
      {
        mode = "n";
        key = "<leader>wj";
        action = "<cmd>resize -4<cr>";
        options = {
          desc = "Decrease Window Height";
        };
      }
      {
        mode = "n";
        key = "<leader>wh";
        action = "<cmd>vertical resize -4<cr>";
        options = {
          desc = "Decrease Window Width";
        };
      }
      {
        mode = "n";
        key = "<leader>wl";
        action = "<cmd>vertical resize +4<cr>";
        options = {
          desc = "Increase Window Width";
        };
      }
      {
        mode = "n";
        key = "<leader>wpd";
        action = "<cmd>:pclose<cr>";
        options = {
          desc = "Close Preview Window";
        };
      }
      {
        mode = "n";
        key = "<leader>wpo";
        action = "<C-w>}";
        options = {
          desc = "Open Preview Window";
        };
      }
    ];
    plugins.which-key.registrations."<leader>w".name = "+window";
    plugins.which-key.registrations."<leader>wp".name = "+preview";
  };
}
