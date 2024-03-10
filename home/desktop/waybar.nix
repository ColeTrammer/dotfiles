{ ... }:

{
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
          format = "{:%H:%M}";
          max-length = 25;
        };
      };
    };
  };

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
