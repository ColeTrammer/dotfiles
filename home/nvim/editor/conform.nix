{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      notifyOnError = true;
      formatOnSave = {};
      formattersByFt = {
        html = [["prettierd" "prettier"]];
        css = [["prettierd" "prettier"]];
        javascript = [["prettierd" "prettier"]];
        javascriptreact = [["prettierd" "prettier"]];
        typescript = [["prettierd" "prettier"]];
        typescriptreact = [["prettierd" "prettier"]];
        python = ["black"];
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = [["prettierd" "prettier"]];
        rust = ["rustfmt"];
      };
    };
  };
}
