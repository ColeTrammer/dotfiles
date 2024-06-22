{
  programs.nixvim = {
    plugins.spectre = {
      enable = true;
      settings.default = {
        find = {
          cmd = "rg";
          options = [ ];
        };
        replace = {
          cmd = "oxi";
        };
      };
    };
    keymaps = [
      {
        key = "<leader>sr";
        mode = "n";
        action = ''<cmd>lua require("spectre").toggle()<CR>'';
        options.desc = "Search and Replace (Spectre)";
      }
      {
        key = "<leader>sp";
        mode = "n";
        action = ''<cmd>lua require("spectre").open_file_search({select_word=true})<CR>'';
        options.desc = "Search current file (Spectre)";
      }
      {
        key = "<leader>sw";
        mode = "n";
        action = ''<cmd>lua require("spectre").open_visual({select_word=true})<CR>'';
        options.desc = "Search current word (Spectre)";
      }
      {
        key = "<leader>sw";
        mode = "v";
        action = ''<cmd>lua require("spectre").open_visual()<CR>'';
        options.desc = "Search current word (Spectre)";
      }
    ];
  };
}
