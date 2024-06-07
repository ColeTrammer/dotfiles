{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    shell.curl.enable =
      lib.mkEnableOption "curl"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.curl.enable {
    home.packages = with pkgs; [
      curl
    ];
  };
}
