{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop.qt.enable =
      lib.mkEnableOption "Qt"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.qt.enable {
    home.packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      breeze-icons
    ];

    qt = {
      enable = true;
      platformTheme = "qtct";
      style = {
        name = "kvantum";
      };
    };
  };
}
