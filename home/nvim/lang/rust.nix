{ helpers, pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        rust = [ "rustfmt" ];
      };
    };
    # NOTE: we have to set this up manually since neotest gets loaded before this plugin would with nixvim.
    extraPlugins = with pkgs.vimPlugins; [ rustaceanvim ];
    extraConfigLuaPre = ''
      vim.g.rustaceanvim = {
          ["dap"] = {
              ["adapter"] = {
                  ["executable"] = {
                      ["args"] = { "--port", "''${port}" },
                      ["command"] = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
                  },
                  ["name"] = "codelldb",
                  ["port"] = "''${port}",
                  ["type"] = "server",
              },
              ["autoload_configurations"] = true,
          },
          ["server"] = {
              ["default_settings"] = { ["check"] = { ["command"] = "clippy" } },
              ["on_attach"] = function(_, bufnr)
                  vim.keymap.set("n", "<leader>cR", function()
                      vim.cmd.RustLsp("codeAction")
                  end, { desc = "Rust Action", buffer = bufnr })
                  vim.keymap.set("n", "<leader>dr", function()
                      vim.cmd.RustLsp("debuggables")
                  end, { desc = "Rust Debuggables", buffer = bufnr })
              end,
          },
      }
    '';
    plugins.neotest.settings.adapters = [
      (helpers.luaExpr ''
        return require("rustaceanvim.neotest")
      '')
    ];
    plugins.crates = {
      enable = true;
      settings = {
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

  nvim.otter.allLangs = [ "rust" ];

  home.packages = with pkgs; [
    cargo-nextest
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];
}
