{
  config,
  lib,
  ...
}: {
  options = {
    desktop.hyprlock.enable =
      lib.mkEnableOption "Hyprlock"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.hyprlock.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        background = [
          {
            monitor = "";
            path = "";
            color = "rgba(0, 0, 0, 1)";
          }
        ];

        input-field = [
          {
            monitor = "";
          }
        ];

        label = [
          {
            monitor = "";
            text = "Hi there, $USER";
            text_align = "center";
            position = "0, 80";
            font_family = "Noto Sans";
            font_size = 25;
            valign = "center";
            halign = "center";
          }
        ];
      };
    };
  };
}
