{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.apps.steam.enable {
    home.packages = with pkgs; [
      steam-run
      mangohud
      protonup
      (pkgs.writeShellScriptBin "evereste-install.sh" ''
        ${pkgs.pipx}/bin/pipx install mons
        ${config.home.homeDirectory}/.local/bin/mons add main '${config.home.homeDirectory}/.local/share/Steam/steamapps/common/Celeste'
        ${pkgs.steam-run}/bin/steam-run ${config.home.homeDirectory}/.local/bin/mons install main stable
      '')
    ];

    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
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
        {
          directory = ".factorio";
          method = "symlink";
        }
      ];
    };
  };
}
