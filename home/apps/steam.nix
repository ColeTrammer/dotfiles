{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    apps.steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.apps.steam.enable {
    home.packages = with pkgs; [
      steam-run
      mangohud
      protonup
    ];

    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
        {
          directory = ".local/share/Celeste";
          method = "symlink";
        }
      ];
    };
  };
}
