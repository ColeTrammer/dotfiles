{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.valgrind.enable = lib.mkEnableOption "valgrind" // {
      default = config.shell.enable && config.preferences.os == "linux";
    };
  };

  config = lib.mkIf config.shell.valgrind.enable { home.packages = with pkgs; [ valgrind ]; };
}
