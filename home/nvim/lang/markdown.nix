{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        markdown = [["prettierd" "prettier"] "markdownlint"];
        "markdown.mdx" = [["prettierd" "prettier"] "markdownlint"];
      };
    };
    plugins.lint.lintersByFt = {
      markdown = ["markdownlint"];
    };
    plugins.lsp.servers.marksman = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    markdownlint-cli
  ];
}
