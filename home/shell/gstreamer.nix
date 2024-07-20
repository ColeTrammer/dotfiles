{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.gstreamer.enable = lib.mkEnableOption "gstreamer" // {
      default = config.shell.enable;
    };
  };

  config = {
    home.packages = with pkgs.gst_all_1; [
      gstreamer
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
      gst-vaapi
    ];
  };
}
