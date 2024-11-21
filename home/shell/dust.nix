{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.dust.enable = lib.mkEnableOption "dust" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.dust.enable { home.packages = with pkgs; [ dust ]; };
}
