{pkgs, ...}: {
  programs.nixvim = {
    plugins.cmp_luasnip = {enable = true;};
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

    keymaps = [
      {
        mode = ["i"];
        key = "<Tab>";
        action = {
          __raw = ''
            function()
              return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end
          '';
        };
        options = {silent = true;};
      }
      {
        mode = ["s"];
        key = "<Tab>";
        action = {
          __raw = ''
            function()
              require("luasnip").jump(1)
            end
          '';
        };
        options = {silent = true;};
      }
      {
        mode = ["i" "s"];
        key = "<S-Tab>";
        action = {
          __raw = ''
            function()
              require("luasnip").jump(-1)
            end
          '';
        };
        options = {silent = true;};
      }
    ];
  };
}
