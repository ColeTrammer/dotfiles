{
  config,
  lib,
  ...
}: {
  options = {
    desktop.udiskie.enable =
      lib.mkEnableOption "udiskie"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.udiskie.enable {
    services.udiskie = {
      enable = true;
    };
  };
}
