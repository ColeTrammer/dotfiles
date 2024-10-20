{
  programs.nixvim = {
    plugins.conform-nvim = {
      settings.formatters_by_ft = {
        yaml = [
          [
            "prettierd"
            "prettier"
          ]
        ];
      };
    };
    plugins.lint.lintersByFt = {
      markdown = [ "markdownlint" ];
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

  nvim.otter.allLangs = [ "yaml" ];
}
