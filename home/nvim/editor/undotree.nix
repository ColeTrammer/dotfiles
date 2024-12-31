{
  programs.nixvim = {
    plugins.undotree = {
      enable = true;
    };
    keymaps = [
      {
        key = "<leader>uu";
        action = "<cmd>UndotreeToggle<cr>";
        options.desc = "Toggle Undo Tree";
      }
    ];
  };
}
