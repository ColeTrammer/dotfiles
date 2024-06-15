{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.cmp.settings.snippet.expand = ''
      function(args)
        require('luasnip').lsp_expand(args.body)
      end;
    '';

    plugins.luasnip = {
      enable = true;
      extraConfig = {
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
}
