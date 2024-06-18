{
  programs.nixvim = {
    plugins.lspkind = {
      enable = true;
      preset = "codicons";
      mode = "symbol_text";
      cmp = {
        maxWidth = 50;
        ellipsisChar = "...";
      };
    };
    plugins.cmp = {
      enable = true;
      settings = {
        experimental = {
          ghost_text = true;
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        window = {
          completion.__raw = "cmp.config.window.bordered()";
          documentation.__raw = "cmp.config.window.bordered()";
        };
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
              ["<Tab>"] = cmp.mapping(function(fallback)
                local luasnip = require("luasnip")
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                local luasnip = require("luasnip")
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" }),
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
      cmdline = {
        "/" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [ { name = "buffer"; } ];
        };
        "?" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [ { name = "buffer"; } ];
        };
        ":" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            { name = "path"; }
            { name = "cmdline"; }
          ];
          matching = {
            disallow_symbol_nonprefix_matching = false;
          };
        };
      };
    };
  };
}
