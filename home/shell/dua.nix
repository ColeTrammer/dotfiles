{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.dua.enable = lib.mkEnableOption "dua" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.dua.enable { home.packages = with pkgs; [ dua ]; };
}
