{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.vttest.enable = lib.mkEnableOption "vttest";
  };

  config = lib.mkIf config.shell.vttest.enable { home.packages = with pkgs; [ vttest ]; };
}
