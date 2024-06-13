{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      notifyOnError = true;
      formatOnSave = ''
        function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return {
            timeout_ms = 500,
            lsp_fallback = true,
            callback = function()
              -- Manually re-show diagnostics after updating the buffer.
              vim.diagnostic.show(nil, bufnr)
            end,
          }
        end
      '';
    };
    userCommands = {
      FormatToggle = {
        command.__raw = ''
          function(args)
            if args.bang then
              vim.b.disable_autoformat = not vim.b.disable_autoformat
            else
              vim.g.disable_autoformat = not vim.g.disable_autoformat
            end

            vim.notify(
              "Global Auto-Format: ["
                .. (vim.g.disable_autoformat and "" or "")
                .. "]\nBuffer Auto-Format: ["
                .. (vim.b.disable_autoformat and "" or "")
                .. "]\n",
              vim.log.levels.info)
          end
        '';
        desc = "Toggle Format on Save";
        bang = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>uf";
        action = "<cmd>FormatToggle<cr>";
        options = {
          desc = "Toggle Format on Save (Global)";
        };
      }
      {
        mode = "n";
        key = "<leader>uF";
        action = "<cmd>FormatToggle!<cr>";
        options = {
          desc = "Toggle Format on Save (Buffer)";
        };
      }
    ];
    extraConfigLua = ''
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    '';
  };
}
