{ helpers, pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        markdown = [
          "prettier"
          "markdownlint"
          "injected"
        ];
        "markdown.mdx" = [
          "prettier"
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
    plugins.render-markdown =
      let
        file_types = [
          "markdown"
          "markdown.mdx"
          "norg"
        ];
      in
      {
        enable = true;
        lazyLoad.settings.ft = file_types;
        settings = {
          file_types = [
          ];
        };
      };
    keymaps = [
      {
        mode = "n";
        key = "<leader>um";
        action = helpers.luaRawExpr ''
          return function()
            require("render-markdown").toggle()
          end
        '';
        options.desc = "Toggle Markdown Rendering";
      }
    ];
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
