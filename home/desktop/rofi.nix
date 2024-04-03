{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop.rofi.enable =
      lib.mkEnableOption "Rofi"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = config.preferences.font.name;
      theme = "Arc-Dark";
    };
  };
}
