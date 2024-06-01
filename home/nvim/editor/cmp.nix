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
        };
        settings = {
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
          sources = {
            __raw = ''
              cmp.config.sources({
                {name = 'nvim_lsp'},
                {name = 'path'},
                }, {
              {name = 'buffer'},
              })
            '';
          };
        };
      };
    };
  };
}
