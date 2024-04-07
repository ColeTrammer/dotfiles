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
          height = 20;
          spacing = 5;
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "tray"
            "cpu"
            "memory"
            "wireplumber"
            "clock"
          ];
          clock = {
            interval = 60;
            format = "{:%I:%M %p}";
            tooltip = false;
          };
          wireplumber = {
            format = "{icon} {volume}%";
            format-icons = ["" "" "󰕾" ""];
            tooltip = false;
          };
          cpu = {
            interval = 1;
            format = "{icon0} {icon1} {icon2} {icon3}";
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          };
          memory = {
            format = "{}% ";
          };
          tray = {
            icon-size = 20;
            spacing = 13;
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
