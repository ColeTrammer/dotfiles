{ helpers, ... }:
{
  programs.nixvim = {
    plugins.lsp-lines = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };
    plugins.lsp = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      preConfig = helpers.lua ''
        -- Setup diagnostics.
        local virtual_text_config = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        }
        local virtual_lines_config = true

        vim.g.lsp_lines_enabled = false
        vim.diagnostic.config({
          underline = true,
          update_in_insert = false,
          virtual_text = virtual_text_config,
          virtual_lines = false,
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
        vim.keymap.set("n", "<leader>uD", function()
          if vim.g.lsp_lines_enabled then
            vim.diagnostic.config({ virtual_lines = false })
            vim.g.lsp_lines_enabled = false
          else
            vim.diagnostic.config({ virtual_lines = virtual_lines_config })
            vim.g.lsp_lines_enabled = true
          end
        end, { desc = "Toogle Diagnostic Virtual Lines" })
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
            action = "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>";
            mode = [ "n" ];
            options = {
              desc = "Goto Definition";
            };
          }
          {
            key = "gr";
            action = "<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>";
            mode = [ "n" ];
            options = {
              desc = "Goto References";
            };
          }
          {
            key = "gI";
            action = "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>";
            mode = [ "n" ];
            options = {
              desc = "Goto Implementation";
            };
          }
          {
            key = "gy";
            action = "<cmd>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>";
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
