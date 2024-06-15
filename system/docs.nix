{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    docs.enable = lib.mkEnableOption "Linux documentation";
  };

  config = lib.mkIf config.docs.enable {
    documentation.enable = true;
    documentation.dev.enable = true;
    documentation.man.enable = true;

    environment.systemPackages = with pkgs; [
      linux-manual
      man-pages
      man-pages-posix
    ];
  };
}
