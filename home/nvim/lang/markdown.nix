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

  nvim.otter = {
    langs = [
      "markdown"
      "markdown.mdx"
    ];
    allLangs = [
      "markdown"
      "markdown.mdx"
    ];
  };

  home.packages = with pkgs; [ markdownlint-cli ];
}
