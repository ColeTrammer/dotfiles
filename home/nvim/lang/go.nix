{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        go = [
          "goimports"
          "gofmt"
        ];
      };
    };
    plugins.lsp = {
      servers.gopls = {
        enable = true;
        package = null;
        onAttach.function = ''
          vim.keymap.set("n", "<leader>td", "<cmd>lua require('dap-go').debug_test()<cr>", { desc = "Debug Nearest (Go)", })
        '';
        settings = {
          codelenses = {
            gc_details = false;
            generate = true;
            regenerate_cgo = true;
            run_govulncheck = true;
            test = true;
            tidy = true;
            upgrade_dependency = true;
            vendor = true;
          };
          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            compositeLiteralTypes = true;
            constantValues = true;
            functionTypeParameters = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };
          analyses = {
            fieldalignment = true;
            nilness = true;
            unusedparams = true;
            unusedwrite = true;
            useany = true;
          };
          usePlaceholders = true;
          completeUnimported = true;
          staticcheck = true;
          directoryFilters = [
            "-.git"
            "-.vscode"
            "-.idea"
            "-.vscode-test"
            "-node_modules"
          ];
          semanticTokens = true;
        };
      };
    };
    plugins.dap.extensions.dap-go = {
      enable = true;
    };
    plugins.neotest.adapters.go = {
      enable = true;
      settings = {
        recursive_run = true;
      };
    };
  };

  nvim.dap.vscode-adapters = {
    delve = [ "go" ];
  };

  home.packages = with pkgs; [
    delve
    gopls
    gotools
    go
  ];
}
