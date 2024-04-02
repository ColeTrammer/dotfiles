{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop.gtk.enable =
      lib.mkEnableOption "GTK"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.gnome.gnome-themes-extra;
        name = "Adwaita-dark";
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
