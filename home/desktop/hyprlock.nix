{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hyprlock.homeManagerModules.default
  ];

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

      backgrounds = [
        {
          monitor = "";
          path = "";
          color = "rgba(0, 0, 0, 1)";
        }
      ];

      input-fields = [
        {
          monitor = "";
        }
      ];

      labels = [
        {
          monitor = "";
        }
      ];
    };
  };
}
