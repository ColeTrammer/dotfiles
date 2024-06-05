{
  programs.nixvim = {
    plugins.conform-nvim = {
      formattersByFt = {
        yaml = [["prettierd" "prettier"]];
      };
    };
    plugins.lint.lintersByFt = {
      markdown = ["markdownlint"];
    };
    plugins.lsp.servers.yamlls = {
      enable = true;
      extraOptions.settings = {
        redhat.telemetry.enabled = false;
        yaml = {
          validate.enable = true;
          keyOrdering = false;
          schemaStore = {
            enable = false;
            url = "";
          };
          schemas.__raw = ''require('schemastore').yaml.schemas()'';
        };
      };
    };
  };
}
