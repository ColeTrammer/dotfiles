{
  config,
  lib,
  ...
}: {
  options = {
    desktop.hyprpaper.enable =
      lib.mkEnableOption "Hyprpaper"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preloads = [
          "~/Pictures/i1.png"
        ];
        wallpapers = [
          ",~/Pictures/i1.png"
        ];
      };
    };
  };
}
