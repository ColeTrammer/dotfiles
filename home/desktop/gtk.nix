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
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "MoreWaita";
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };

    fonts.fontconfig.enable = true;

    home.packages = [
      config.preferences.font.package
    ];

    home.file.".local/share/themes/adw-gtk3-dark" = {
      source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
