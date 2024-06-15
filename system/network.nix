{ config, lib, ... }:
{
  options = {
    network.enable = lib.mkEnableOption "Networking and Bluetooth" // {
      default = true;
    };
  };

  config = lib.mkIf config.network.enable {
    networking.networkmanager.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services.blueman.enable = true;

    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
      ];
    };

    # For some reason persisting /var/lib/NetworkManager does not result in the WIFI password being saved.
    systemd.tmpfiles.rules = [
      "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
      "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
      "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
    ];
  };
}
