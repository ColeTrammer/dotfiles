{
  programs.nixvim = {
    plugins.nvim-ufo = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "zR";
        action.__raw = ''function() require("ufo").openAllFolds() end'';
        options = {
          desc = "Open All Folds";
        };
      }
      {
        mode = "n";
        key = "zM";
        action.__raw = ''function() require("ufo").closeAllFolds() end'';
        options = {
          desc = "Close All Folds";
        };
      }
    ];
  };
}
