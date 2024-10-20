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
    plugins.render-markdown = {
      enable = true;
      settings = {
        file_types = [
          "markdown"
          "markdown.mdx"
          "norg"
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
