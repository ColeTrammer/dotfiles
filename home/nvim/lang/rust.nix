{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        rust = [ "rustfmt" ];
      };
    };
    plugins.rustaceanvim = {
      enable = true;
      rustAnalyzerPackage = null;
      settings = {
        dap = {
          adapter = {
            type = "server";
            name = "codelldb";
            port = "\${port}";
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = [
                "--port"
                "\${port}"
              ];
            };
          };

          autoload_configurations = true;
        };
        server = {
          on_attach = ''
            function(_, bufnr)
              vim.keymap.set("n", "<leader>cR", function()
                vim.cmd.RustLsp("codeAction")
              end, { desc = "Rust Action", buffer = bufnr })
              vim.keymap.set("n", "<leader>dr", function()
                vim.cmd.RustLsp("debuggables")
              end, { desc = "Rust Debuggables", buffer = bufnr })
            end
          '';
          default_settings = {
            check = {
              command = "clippy";
            };
          };
        };
      };
    };
    plugins.neotest.adapters.rust = {
      enable = true;
    };
    plugins.crates-nvim = {
      enable = true;
      extraOptions = {
        completion.cmp.enabled = true;
      };
    };
    plugins.lsp.servers.taplo.onAttach.function = ''
      vim.keymap.set("n", "K", function()
        if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
          require("crates").show_popup()
        else
          vim.lsp.buf.hover()
        end
      end, { buffer = bufnr })
    '';
    plugins.cmp.settings.sources = [ { name = "crates"; } ];
  };

  home.packages = with pkgs; [
    cargo-nextest
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];
}
