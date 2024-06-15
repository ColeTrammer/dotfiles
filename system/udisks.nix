{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    udisks.enable = lib.mkEnableOption "udisks" // {
      default = true;
    };
  };

  config = lib.mkIf config.udisks.enable {
    environment.systemPackages = with pkgs; [ ntfs3g ];

    services.udisks2 = {
      enable = true;
      settings = {
        "mount_options.conf" = {
          defaults = {
            ntfs_drivers = "ntfs-3g,ntfs3,ntfs";
          };
        };
      };
    };
  };
}
