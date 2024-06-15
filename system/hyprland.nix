{ config, lib, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Hyprland" // {
      default = true;
    };
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
    };

    security.pam.services.hyprlock = { };
  };
}
