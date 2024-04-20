{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    apps.discord.enable =
      lib.mkEnableOption "Discord"
      // {
        default = config.apps.enable;
      };
  };

  config = lib.mkIf config.apps.discord.enable {
    home.packages = with pkgs; [
      discord
      vesktop
    ];

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".config/discord";
          method = "symlink";
        }
        {
          directory = ".config/vesktop";
          method = "symlink";
        }
      ];
    };
  };
}
