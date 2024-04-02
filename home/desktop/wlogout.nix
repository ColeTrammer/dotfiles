{
  config,
  lib,
  ...
}: {
  options = {
    desktop.wlogout.enable =
      lib.mkEnableOption "wlogout"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.wlogout.enable {
    programs.wlogout = {
      enable = true;
    };
  };
}
