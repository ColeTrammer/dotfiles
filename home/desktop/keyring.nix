{ config, lib, ... }:
{
  options = {
    desktop.keyring.enable = lib.mkEnableOption "Keyring" // {
      default = config.desktop.enable;
    };
  };

  config = lib.mkIf config.desktop.keyring.enable {
    home.persistence."/persist/home" = {
      directories = [ ".local/share/keyrings" ];
      allowOther = true;
    };
  };
}
