{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        json = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          __unkeyed-3 = "jq";
          stop_after_first = true;
        };
        jsonc = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          __unkeyed-3 = "jq";
          stop_after_first = true;
        };
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
