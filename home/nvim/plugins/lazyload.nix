{
  config,
  helpers,
  lib,
  ...
}:
{
  options = {
    nvim.plugins = lib.mkOption {
      description = "Plugin specs. Primarily declare plugin dependencies.";
      type =
        with lib.types;
        attrsOf (submodule {
          options = {
            dependencies = lib.mkOption {
              description = "Module dependencies.";
              type = listOf str;
              default = [ ];
            };
          };
        });
    };
  };

  config =
    let
      baseConfig = {
        # Lazy load plugins.
        plugins.lz-n.enable = true;
      };
      cfg = config.programs.nixvim;
      makeLazyLoad =
        plugin:
        let
          pluginConfig = cfg.plugins.${plugin};
          pluginName = pluginConfig.package.pname;
          check = lib.assertMsg (pluginConfig.enable) "Dependency ${plugin} must be enabled.";
        in
        assert check;
        helpers.lua ''
          require("lz.n").trigger_load("${pluginName}")
        '';
      makeLazyLoads =
        plugin:
        { dependencies, ... }:
        let
          lazyLoads = dependencies |> map makeLazyLoad |> lib.strings.concatLines;
        in
        {
          plugins.${plugin}.lazyLoad.settings.before = helpers.luaRawExpr ''
            return function() 
              ${lazyLoads}
            end
          '';
        };
      pluginConfigs = lib.attrsets.mapAttrsToList makeLazyLoads config.nvim.plugins;
      configs = pluginConfigs ++ [ baseConfig ];
    in
    {
      programs.nixvim = lib.mkMerge configs;
    };
}
