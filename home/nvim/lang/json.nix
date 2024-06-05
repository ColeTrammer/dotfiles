{pkgs, ...}: {
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        json = [["prettierd" "prettier"]];
        jsonc = [["prettierd" "prettier"]];
      };
    };
    plugins.lsp.servers.jsonls = {
      enable = true;
      settings = {
        schemas.__raw = ''require('schemastore').json.schemas()'';
        validate.enable = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      SchemaStore-nvim
    ];
  };
}
