{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.gstreamer = {
      enable = lib.mkEnableOption "gstreamer" // {
        default = config.shell.enable;
      };
      enableVaapi = lib.mkEnableOption "gstreamer vaapi" // {
        default = config.shell.gstreamer.enable && config.preferences.os == "linux";
      };
    };
  };

  config = {
    home.packages =
      with pkgs.gst_all_1;
      [
        gstreamer
        gst-plugins-base
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]
      ++ (if config.shell.gstreamer.enableVaapi then [ gst-vaapi ] else [ ]);
  };
}
