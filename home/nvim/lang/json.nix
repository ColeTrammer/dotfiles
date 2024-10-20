{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        json = [
          [
            "prettierd"
            "prettier"
            "jq"
          ]
        ];
        jsonc = [
          [
            "prettierd"
            "prettier"
            "jq"
          ]
        ];
      };
    };
    plugins.lsp.servers.jsonls = {
      enable = true;
      settings = {
        schemas.__raw = ''require('schemastore').json.schemas()'';
        validate.enable = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [ SchemaStore-nvim ];
  };

  nvim.otter.allLangs = [ "json jsonc" ];
}
