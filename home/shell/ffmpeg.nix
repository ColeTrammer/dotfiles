{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.ffmpeg.enable = lib.mkEnableOption "ffmpeg" // {
      default = config.shell.enable;
    };
  };

  config = {
    home.packages = with pkgs; [ ffmpeg-full ];
  };
}
