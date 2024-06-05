{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>un";
        action.__raw = ''
          (function()
            local number = true;
            local relativenumber = true;
            return function()
              if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
                number = vim.opt_local.number:get()
                relativenumber = vim.opt_local.relativenumber:get()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
              else
                vim.opt_local.number = number
                vim.opt_local.relativenumber = relativenumber
              end
            end
          end)()
        '';
        options = {
          desc = "Toggle Line Numbers";
        };
      }
      {
        mode = "n";
        key = "<leader>uN";
        action.__raw = ''
          function()
            vim.opt_local.relativenumber = not vim.opt_local.relativenumber:get()
          end
        '';
        options = {
          desc = "Toggle Relative Line Numbers";
        };
      }
      {
        mode = "n";
        key = "<leader>uw";
        action.__raw = ''
          function()
            vim.opt_local.wrap = not vim.opt_local.wrap:get()
          end
        '';
        options = {
          desc = "Toggle Word Wrap";
        };
      }
      {
        mode = "n";
        key = "<leader>us";
        action.__raw = ''
          function()
            vim.opt_local.spell = not vim.opt_local.spell:get()
          end
        '';
        options = {
          desc = "Toggle Spell Check";
        };
      }
      {
        mode = "n";
        key = "<leader>uh";
        action.__raw = ''
          function()
            local value = not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
            vim.lsp.inlay_hint.enable(value)
          end
        '';
        options = {
          desc = "Toggle Inlay Hints";
        };
      }
      {
        mode = "n";
        key = "<leader>ud";
        action.__raw = ''
          function()
            if vim.diagnostic.is_enabled() then
              vim.diagnostic.disable()
            else
              vim.diagnostic.enable()
            end
          end
        '';
        options = {
          desc = "Toggle Diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>uT";
        action.__raw = ''
          function()
            if vim.b.ts_highlight then
              vim.treesitter.stop()
            else
              vim.treesitter.start()
            end
          end
        '';
        options = {
          desc = "Toggle Treesitter";
        };
      }
    ];
    plugins.which-key.registrations."<leader>u".name = "+toggle";
  };
}
