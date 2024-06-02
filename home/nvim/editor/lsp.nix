{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      preConfig = ''
        -- Setup diagnostics.
        vim.diagnostic.config({
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = function(diagnostic)
              if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return " "
              elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                return " "
              elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                return " "
              elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                return " "
              else
                return "●"
              end
            end,
          },
          severity_sort = true,
        })
      '';
      onAttach = ''
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      '';
      keymaps = {
        extra = [
          {
            key = "<leader>cx";
            action = "<CMD>LspStop<Enter>";
            mode = ["n"];
            options = {desc = "Lsp Stop";};
          }
          {
            key = "<leader>cl";
            action = "<CMD>LspInfo<Enter>";
            mode = ["n"];
            options = {desc = "Lsp Info";};
          }
          {
            key = "gK";
            action.__raw = "vim.lsp.buf.signature_help";
            mode = ["n"];
            options = {desc = "Signature Help";};
          }
          {
            key = "<leader>ca";
            action.__raw = "vim.lsp.buf.code_action";
            mode = ["n" "v"];
            options = {desc = "Code Action";};
          }
          {
            key = "<leader>cr";
            action.__raw = "vim.lsp.buf.rename";
            mode = ["n" "v"];
            options = {desc = "Rename";};
          }
          {
            key = "gd";
            action = {__raw = "function() require('telescope.builtin').lsp_definitions({ reuse_win = true }) end";};
            mode = ["n"];
            options = {desc = "Goto Definition";};
          }
          {
            key = "gr";
            action = {__raw = "function() require('telescope.builtin').lsp_references({ reuse_win = true }) end";};
            mode = ["n"];
            options = {desc = "Goto References";};
          }
          {
            key = "gI";
            action = {__raw = "function() require('telescope.builtin').lsp_implementations({ reuse_win = true }) end";};
            mode = ["n"];
            options = {desc = "Goto Implementation";};
          }
          {
            key = "gy";
            action = {__raw = "function() require('telescope.builtin').lsp_type_definitions({ reuse_win = true }) end";};
            mode = ["n"];
            options = {desc = "Goto T[y]pe Definition";};
          }
          {
            key = "gD";
            action = {__raw = "vim.lsp.buf.declaration";};
            mode = ["n"];
            options = {desc = "Goto Declartion";};
          }
        ];
      };
    };
  };
}
