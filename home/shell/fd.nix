{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    shell.fd.enable =
      lib.mkEnableOption "fd"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.fd.enable {
    home.packages = with pkgs; [
      fd
    ];
  };
}
