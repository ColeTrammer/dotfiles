{
  helpers,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins.blink-cmp.settings = {
      snippets = {
        expand = helpers.luaRawExpr ''
          return function(snippet)
            require("luasnip").lsp_expand(snippet)
          end
        '';
        active = helpers.luaRawExpr ''
          return function(filter)
            if filter and filter.direction then
              return require("luasnip").jumpable(filter.direction)
            end
            return require("luasnip").in_snippet()
          end
        '';
        jump = helpers.luaRawExpr ''
          return function(direction)
            require("luasnip").jump(direction)
          end
        '';
      };

      # Make snippets show up first with exact matches. Otherwise
      # snippets are getting buried by gopls.
      sources.providers.luasnip.score_offset = 1;
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
  nvim.blink-cmp.extraSources = [ "luasnip" ];
}
