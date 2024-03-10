{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  services.udisks2 = {
    enable = true;
    settings = {
      "mount_options.conf" =
        {
          defaults = {
            ntfs_drivers = "ntfs-3g,ntfs3,ntfs";
          };
        };
    };
  };
}
