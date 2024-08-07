{
  programs.nixvim = {
    keymaps = [
      # Better up/down (accounts for word wrap)
      {
        mode = [
          "n"
          "x"
        ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          desc = "Down";
          silent = true;
          expr = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          desc = "Up";
          silent = true;
          expr = true;
        };
      }
      # Clear search on escape
      {
        mode = [
          "i"
          "n"
        ];
        key = "<esc>";
        action = "<cmd>noh<CR><esc>";
        options = {
          desc = "Escape";
        };
      }
      # Better indenting (stay selected)
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options = {
          desc = "Indent Left";
        };
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options = {
          desc = "Indent Right";
        };
      }
      # Auto-center screen when scolling.
      {
        mode = [ "n" ];
        key = "<C-d>";
        action = "<C-d>zz";
        options = {
          desc = "Scroll Down";
        };
      }
      {
        mode = [ "n" ];
        key = "<C-u>";
        action = "<C-u>zz";
        options = {
          desc = "Scroll Up";
        };
      }
      # Move around in insert mode
      {
        mode = [ "i" ];
        key = "<C-h>";
        action = "<Left>";
        options = {
          desc = "Left";
        };
      }
      {
        mode = [ "i" ];
        key = "<C-l>";
        action = "<Right>";
        options = {
          desc = "Right";
        };
      }
      {
        mode = [ "i" ];
        key = "<C-k>";
        action = "<Up>";
        options = {
          desc = "Up";
        };
      }
      {
        mode = [ "i" ];
        key = "<C-j>";
        action = "<Down>";
        options = {
          desc = "Down";
        };
      }
      # Save file
      {
        mode = [
          "n"
          "x"
          "s"
          "i"
        ];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options = {
          desc = "Save File";
        };
      }
      # Enter normal mode
      {
        mode = "i";
        key = "<C-c>";
        action = "<esc>";
        options.desc = "Enter Normal Mode";
      }
      # Quit
      {
        mode = [ "n" ];
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options = {
          desc = "Quit All";
        };
      }
      # diagnostic
      {
        mode = "n";
        key = "<leader>cd";
        action.__raw = "vim.diagnostic.open_float";
        options = {
          desc = "Line diagnostics";
        };
      }
      # Quickfix
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>lopen<cr>";
        options = {
          desc = "Location List";
        };
      }
      {
        mode = "n";
        key = "<leader>xq";
        action = "<cmd>copen<cr>";
        options = {
          desc = "Quickfix List";
        };
      }
      # Terminal escape to normal mode
      {
        mode = "t";
        key = "<esc><esc>";
        action = "[[<C-\\><C-n>]]";
        options = {
          desc = "Switch to Noral Mode";
        };
      }
    ];
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>q";
        group = "+session";
      }
      {
        __unkeyed-1 = "<leader>x";
        group = "+diagnostic";
      }
    ];
  };
}
