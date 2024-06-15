{ config, lib, ... }:
{
  options = {
    desktop.kdeconnect.enable = lib.mkEnableOption "kdeconnect" // {
      default = config.desktop.enable;
    };
  };

  config = lib.mkIf config.desktop.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [ ".config/kdeconnect" ];
    };
  };
}
