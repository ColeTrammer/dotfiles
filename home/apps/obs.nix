{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.obs.enable = lib.mkEnableOption "OBS";
  };

  config = lib.mkIf config.apps.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-livesplit-one
        obs-pipewire-audio-capture
        input-overlay
      ];
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".config/obs-studio";
          method = "symlink";
        }
      ];
    };
  };
}
