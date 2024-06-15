{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        markdown = [
          [
            "prettierd"
            "prettier"
          ]
          "markdownlint"
          "injected"
        ];
        "markdown.mdx" = [
          [
            "prettierd"
            "prettier"
          ]
          "markdownlint"
          "injected"
        ];
      };
    };
    plugins.lint.lintersByFt = {
      markdown = [ "markdownlint" ];
    };
    plugins.lsp.servers.marksman = {
      enable = true;
    };
  };

  home.packages = with pkgs; [ markdownlint-cli ];
}
