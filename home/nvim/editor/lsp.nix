{ helpers, ... }:
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      preConfig = helpers.lua ''
        -- Setup diagnostics.
        vim.diagnostic.config({
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.HINT] = " ",
              [vim.diagnostic.severity.INFO] = " ",
            },
          },
        })
      '';
      inlayHints = true;
      keymaps = {
        extra = [
          {
            key = "<leader>cX";
            action = "<CMD>LspStop<Enter>";
            mode = [ "n" ];
            options = {
              desc = "Lsp Stop";
            };
          }
          {
            key = "<leader>cx";
            action = "<CMD>LspRestart<Enter>";
            mode = [ "n" ];
            options = {
              desc = "Lsp Restart";
            };
          }
          {
            key = "<leader>cL";
            action = "<CMD>LspStart<Enter>";
            mode = [ "n" ];
            options = {
              desc = "Lsp Start";
            };
          }
          {
            key = "<leader>cl";
            action = "<CMD>LspInfo<Enter>";
            mode = [ "n" ];
            options = {
              desc = "Lsp Info";
            };
          }
          {
            key = "gK";
            action.__raw = "vim.lsp.buf.signature_help";
            mode = [ "n" ];
            options = {
              desc = "Signature Help";
            };
          }
          {
            key = "<leader>ca";
            action.__raw = "vim.lsp.buf.code_action";
            mode = [
              "n"
              "v"
            ];
            options = {
              desc = "Code Action";
            };
          }
          {
            key = "gd";
            action = "<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>";
            mode = [ "n" ];
            options = {
              desc = "Goto Definition";
            };
          }
          {
            key = "gr";
            action = "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>";
            mode = [ "n" ];
            options = {
              desc = "Goto References";
            };
          }
          {
            key = "gI";
            action = "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>";
            mode = [ "n" ];
            options = {
              desc = "Goto Implementation";
            };
          }
          {
            key = "gy";
            action = "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>";
            mode = [ "n" ];
            options = {
              desc = "Goto T[y]pe Definition";
            };
          }
          {
            key = "gD";
            action.__raw = "vim.lsp.buf.declaration";
            mode = [ "n" ];
            options = {
              desc = "Goto Declartion";
            };
          }
        ];
      };
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>c";
        group = "+code";
      }
    ];
  };
}
