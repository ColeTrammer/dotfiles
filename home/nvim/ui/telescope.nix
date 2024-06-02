{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        fzf-native = {
          enable = true;
        };
      };
      keymaps = {
        "<leader><space>" = {
          action = "find_files";
          options.desc = "Find Files";
        };
        "<leader>/" = {
          action = "live_grep";
          options.desc = "Search Files";
        };
        "<leader>:" = {
          action = "command_history";
          options.desc = "Command History";
        };
        "<leader>," = {
          action = "buffers sort_mru=true sort_lastused=true";
          options.desc = "Switch Buffer";
        };
        "<leader>bb" = {
          action = "buffers sort_mru=true sort_lastused=true";
          options.desc = "Switch Buffer";
        };
      };
    };
  };
}
