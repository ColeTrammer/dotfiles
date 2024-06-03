{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        javascript = [["prettierd" "prettier"]];
        javascriptreact = [["prettierd" "prettier"]];
        "javascript.jsx" = [["prettierd" "prettier"]];
        typescript = [["prettierd" "prettier"]];
        typescriptreact = [["prettierd" "prettier"]];
        "typescript.tsx" = [["prettierd" "prettier"]];
      };
    };
    plugins.lsp.servers = {
      tsserver = {
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

  home.packages = with pkgs; [
    prettierd
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
    nodePackages_latest.eslint
  ];
}
