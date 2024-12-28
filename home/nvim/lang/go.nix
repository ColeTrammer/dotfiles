{
  helpers,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        go = [
          "goimports"
          [
            "gofmt"
            "gofumpt"
          ]
        ];
      };
    };
    plugins.lsp = {
      servers.gopls = {
        enable = true;
        package = null;
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
    plugins.neotest.settings.adapters = [
      (helpers.luaExpr ''
        return (function()
          local neotest_golang = require("neotest-golang")
          neotest_golang({ go_test_args = { "-v", "-count=1", "-timeout=60s" }, dap_go_enabled = true })
          return neotest_golang
        end)()
      '')
    ];
    extraPlugins = with pkgs; [
      vimPlugins.neotest-golang
    ];
  };

  nvim.dap.vscode-adapters = {
    delve = [ "go" ];
  };

  nvim.otter.allLangs = [ "go" ];

  home.packages = with pkgs; [
    delve
    gopls
    gotools
    go
  ];
}
