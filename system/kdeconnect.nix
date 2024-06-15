{ config, lib, ... }:
{
  options = {
    kdeconnect.enable = lib.mkEnableOption "kdeconnect" // {
      default = true;
    };
  };

  config = lib.mkIf config.kdeconnect.enable { programs.kdeconnect.enable = true; };
}
