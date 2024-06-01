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
          options.desc = "Find Files (Root Dir)";
        };
        "<leader>/" = {
          action = "live_grep";
          options.desc = "Grep (Root Dir)";
        };
        "<leader>:" = {
          action = "command_history";
          options.desc = "Command History";
        };
      };
    };
  };
}
