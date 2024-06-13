{
  programs.nixvim = {
    plugins.neogen = {
      enable = true;
      snippetEngine = "luasnip";
    };
    keymaps = [
      {
        mode = "n";
        key = "cn";
        action.__raw = ''function() require("neogen").generate() end'';
        options = {
          desc = "Generate Annotations";
        };
      }
    ];
  };
}
