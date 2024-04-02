{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options = {
    hyprland.enable =
      lib.mkEnableOption "Hyprland"
      // {
        default = true;
      };
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    security.pam.services.hyprlock = {};
  };
}
