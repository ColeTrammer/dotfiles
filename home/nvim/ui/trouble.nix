{ helpers, pkgs, ... }:
{
  programs.nixvim = {
    # Don't use the nixvim way to configure this plugin since it needs to init before lualine.
    extraPlugins = [ pkgs.vimPlugins.trouble-nvim ];
    plugins.lualine.sections.lualine_c = [
      {
        extraConfig = helpers.luaRawExpr ''
          return (function()
            local trouble = require("trouble")

            -- This is required since trouble would otherwise get loaded after lualine...
            trouble.setup({ use_diagnostic_signs = true })

            local symbols = trouble.statusline({
              mode = "lsp_document_symbols",
              groups = {},
              title = false,
              filter = { range = true },
              format = "{kind_icon}{symbol.name:Normal}",
              -- The following line is needed to fix the background color
              -- Set it to the lualine section you want to use
              hl_group = "lualine_c_normal",
            })
            return {
              symbols.get,
              cond = symbols.has,
            }
          end)()
        '';
      }
    ];
    plugins.telescope.settings.defaults.mappings = {
      i."<c-t>".__raw = ''require("trouble.sources.telescope").open'';
      n."<c-t>".__raw = ''require("trouble.sources.telescope").open'';
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options = {
          desc = "Diagnostics (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options = {
          desc = "Buffer Diagnostics (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options = {
          desc = "Symbols (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>cS";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options = {
          desc = "LSP References (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options = {
          desc = "Location List (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options = {
          desc = "Quickfix List (Trouble)";
        };
      }
      {
        mode = "n";
        key = "]q";
        action = helpers.luaRawExpr ''
          return function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
        options = {
          desc = "Next Quickfix";
        };
      }
      {
        mode = "n";
        key = "[q";
        action = helpers.luaRawExpr ''
          return function()
            if require("trouble").is_open() then
              require("trouble").prev({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
        options = {
          desc = "Prev Quickfix";
        };
      }
    ];
    autoCmd = [
      {
        event = "QuickFixCmdPost";
        callback = helpers.luaRawExpr ''
          return function()
            vim.cmd([[Trouble qflist open]])
          end'';
      }
    ];
  };
}
