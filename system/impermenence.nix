{
  config,
  lib,
  ...
}: {
  options = {
    impermenence = {
      enable =
        lib.mkEnableOption "Impermenence"
        // {
          default = true;
        };

      initrdSystemd = lib.mkEnableOption "initrd systemd";
    };
  };

  config = lib.mkIf config.impermenence.enable (let
    deleteRoot = ''
      mkdir /btrfs_tmp
      mount /dev/mapper/crypted /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  in {
    # Delete root volumes on boot.
    boot.initrd.postDeviceCommands = lib.mkIf (!config.impermenence.initrdSystemd) (lib.mkAfter deleteRoot);
    boot.initrd.systemd.services = lib.mkIf config.impermenence.initrdSystemd {
      initrd-delete-root = {
        wantedBy = ["initrd-switch-root.target"];
        after = ["cryptsetup.target"];
        before = ["persist.mount"];
        description = "Delete root fs";
        unitConfig.DefaultDependencies = "no";
        serviceConfig = {
          Type = "oneshot";
        };
        script = deleteRoot;
      };
      persist-early-files = {
        description = "Link early boot files from /persist";
        wantedBy = [
          "initrd-switch-root.target"
        ];
        after = [
          "persist.mount"
        ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir -p /sysroot/etc/
          ln -snfT /persist/system/etc/machine-id /sysroot/etc/machine-id
        '';
      };
    };

    # Need for boot to succeed.
    fileSystems."/persist".neededForBoot = true;

    # Need to home manager persistence.
    programs.fuse.userAllowOther = true;

    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/db/sudo/lectured"
        "/var/lib/systemd/coredump"
      ];
      files = lib.mkIf (!config.impermenence.initrdSystemd) [
        "/etc/machine-id"
      ];
    };
  });
}
