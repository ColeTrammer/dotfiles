{
  config,
  lib,
  ...
}: {
  options = {
    desktop.mako.enable =
      lib.mkEnableOption "Mako"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.mako.enable {
    services.mako = {
      enable = true;
      defaultTimeout = 3000;
      ignoreTimeout = true;
    };
  };
}
