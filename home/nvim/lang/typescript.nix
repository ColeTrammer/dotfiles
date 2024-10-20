{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        javascript = {
          __unkeyed-0 = "prettierd";
          __unkeyed-1 = "prettier";
          stop_after_first = true;
        };
        javascriptreact = {
          __unkeyed-0 = "prettierd";
          __unkeyed-1 = "prettier";
          stop_after_first = true;
        };
        "javascript.jsx" = {
          __unkeyed-0 = "prettierd";
          __unkeyed-1 = "prettier";
          stop_after_first = true;
        };
        typescript = {
          __unkeyed-0 = "prettierd";
          __unkeyed-1 = "prettier";
          stop_after_first = true;
        };
        typescriptreact = {
          __unkeyed-0 = "prettierd";
          __unkeyed-1 = "prettier";
          stop_after_first = true;
        };
        "typescript.tsx" = {
          __unkeyed-0 = "prettierd";
          __unkeyed-1 = "prettier";
          stop_after_first = true;
        };
      };
    };
    plugins.lsp.servers = {
      ts_ls = {
        enable = true;
        package = null;
        extraOptions.settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayVariableTypeHints = true;
            };
          };
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayVariableTypeHints = true;
            };
          };
        };
      };
      eslint = {
        enable = true;
        package = null;
        extraOptions.settings = {
          workingDirectories.mode = "auto";
        };
      };
    };
  };

  nvim.otter.allLangs = [
    "javascript"
    "javascriptreact"
    "javascript.jsx"
    "typescript"
    "typescriptreact"
    "typescript.tsx"
  ];

  home.packages = with pkgs; [
    prettierd
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
    nodePackages_latest.eslint
  ];
}
