{
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins.blink-cmp.settings = {
      snippets = {
        preset = "luasnip";
      };
    };

    plugins.luasnip = {
      enable = true;
      lazyLoad.settings.lazy = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
      fromVscode = [
        {
          lazyLoad = true;
          paths = "${pkgs.vimPlugins.friendly-snippets}";
        }
      ];
    };
  };
  nvim.plugins.blink-cmp.dependencies = [ "luasnip" ];
}
