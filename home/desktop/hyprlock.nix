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
          }
        ];
      };
    };
  };
}
