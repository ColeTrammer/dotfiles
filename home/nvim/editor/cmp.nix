{
  programs.nixvim = {
    plugins = {
      cmp-nvim-lsp = {enable = true;};
      cmp-buffer = {enable = true;};
      cmp-path = {enable = true;};
      cmp = {
        enable = true;
        settings = {
          experimental = {
            ghost_text = true;
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "buffer";}
          ];
          mapping = {
            __raw = ''
               cmp.mapping.preset.insert({
                 ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                 ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                 ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
                 ["<C-Space>"] = cmp.mapping.complete(),
                 ["<C-e>"] = cmp.mapping.abort(),
                 ["<CR>"] = function(fallback)
                   if cmp.visible() then
                     cmp.confirm({ select = true, })
                   else
                     fallback()
                   end
                 end,
                 -- C-] maps to shift+enter in my terminal config
                 ["<C-]>"] = function(fallback)
                   if cmp.visible() then
                     cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
                   else
                     fallback()
                   end
                 end,
                 -- C-^ maps to ctrl+enter in my terminal config
                 ["<C-^>"] = function(fallback)
                   cmp.abort()
                   fallback()
                 end,
              })
            '';
          };
        };
      };
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
