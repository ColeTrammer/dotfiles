{ helpers, pkgs, ... }:
{
  programs.nixvim = {
    # We're not using the nixvim version since we're going to set this up manually.
    extraPlugins = with pkgs.vimPlugins; [ lspkind-nvim ];
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
        formatting = {
          fields = [
            "kind"
            "abbr"
            "menu"
          ];
          format = helpers.luaRawExpr ''
            return function(entry, vim_item)
              local kind = require("lspkind").cmp_format({ mode = "symbol", maxwidth = 50 })(entry, vim_item)

              -- Ensure kind is 3 chars
              if kind.kind ~= nil then
                while string.len(kind.kind) < 3 do
                  kind.kind = kind.kind .. " "
                end
              end

              -- 1 char worth of padding (unless already inserted by the LSP [clangd])
              if not kind.abbr:find("^•") and not kind.abbr:find("^ ") then
                kind.abbr = " " .. kind.abbr
              end
              return kind
            end
          '';
        };
        window = {
          completion = helpers.luaRaw ''
            cmp.config.window.bordered({ col_offset = -4 })
          '';
          documentation = helpers.luaRaw "cmp.config.window.bordered()";
        };
        mapping = helpers.luaRaw ''
          cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = function(fallback)
              if cmp.visible() then
                cmp.confirm({ select = true })
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
        enabled = helpers.luaRawExpr ''
          return function()
            -- disable completion in comments
            local context = require("cmp.config.context")
            -- keep command mode completion enabled when cursor is in a comment
            if vim.api.nvim_get_mode().mode == "c" then
              return true
            else
              return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
            end
          end
        '';
      };
      cmdline = {
        "/" = {
          mapping = helpers.luaRaw "cmp.mapping.preset.cmdline()";
          sources = [ { name = "buffer"; } ];
        };
        "?" = {
          mapping = helpers.luaRaw "cmp.mapping.preset.cmdline()";
          sources = [ { name = "buffer"; } ];
        };
        ":" = {
          mapping = helpers.luaRaw "cmp.mapping.preset.cmdline()";
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
    keymaps = [
      {
        mode = "n";
        key = "<leader>ua";
        action = helpers.luaRaw ''
          (function()
            local enabled = true
            local cmp = require("cmp")
            return function()
              cmp.setup.buffer({ enabled = not enabled })
              enabled = not enabled
            end
          end)()
        '';
        options.desc = ''Toogle Auto-Complete'';
      }
    ];
    autoGroups.disableCmp.clear = true;
    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [
          "NeogitCommitMessage"
          "gitcommit"
          "TelescopePrompt"
        ];
        group = "disableCmp";
        callback = helpers.luaRawExpr ''
          return function()
            local cmp = require("cmp")
            cmp.setup.buffer({ enabled = false })
          end
        '';
      }
    ];
  };
}
