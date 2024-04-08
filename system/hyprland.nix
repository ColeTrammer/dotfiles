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
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };

    security.pam.services.hyprlock = {};
  };
}
