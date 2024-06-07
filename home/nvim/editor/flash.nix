{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
    };
    keymaps = [
      {
        key = "s";
        mode = ["n" "x" "o"];
        action.__raw = ''function() require("flash").jump() end'';
        options.desc = "Flash";
      }
      {
        key = "S";
        mode = ["n" "o" "x"];
        action.__raw = ''function() require("flash").treesitter() end'';
        options.desc = "Flash Treesitter";
      }
      {
        key = "r";
        mode = "o";
        action.__raw = ''function() require("flash").remote() end'';
        options.desc = "Remote Flash";
      }
      {
        key = "R";
        mode = ["o" "x"];
        action.__raw = ''function() require("flash").treesitter_search() end'';
        options.desc = "Treesitter Search";
      }
      {
        key = "<c-s>";
        mode = "c";
        action.__raw = ''function() require("flash").toggle() end'';
        options.desc = "Toggle Flash Search";
      }
    ];
  };
}
