{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    desktop.enable = lib.mkEnableOption "Desktop Environment";
  };

  config = lib.mkIf config.desktop.enable {
    home.packages = with pkgs; [
      playerctl
      xdg-utils
    ];
  };
}
