{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop.cursor.enable =
      lib.mkEnableOption "Cursor Theme"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.cursor.enable {
    home.pointerCursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      size = 32;
      gtk.enable = true;
    };
  };
}
