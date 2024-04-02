{
  config,
  lib,
  ...
}: {
  options = {
    desktop.waybar.enable =
      lib.mkEnableOption "Waybar"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      settings = {
        mainBar = {
          layer = "top";
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "clock"
            "tray"
          ];
          clock = {
            interval = 60;
            format = "{:%I:%M %p}";
            max-length = 25;
          };
        };
      };
    };

    services = {
      blueman-applet.enable = true;
      network-manager-applet.enable = true;
    };
  };
}
