{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    plymouth = {
      enable = lib.mkEnableOption "plymouth" // {default = true;};

      dpi = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = ''Boot DPI'';
      };
    };
  };

  config = lib.mkIf config.plymouth.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "catppuccin-mocha";
        themePackages = [
          (pkgs.catppuccin-plymouth.override
            {
              variant = "mocha";
            })
        ];
        extraConfig = ''
          DeviceScale=${builtins.toString config.plymouth.dpi};
        '';
      };
      initrd.systemd.enable = true;
      kernelParams = ["quiet"];
    };

    impermenence.initrdSystemd = true;
  };
}
