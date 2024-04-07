{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    plymouth.enable = lib.mkEnableOption "plymouth" // {default = true;};
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
      };
      initrd.systemd.enable = true;
      kernelParams = ["quiet"];
    };

    impermenence.initrdSystemd = true;
  };
}
