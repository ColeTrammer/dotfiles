{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.just.enable = lib.mkEnableOption "just" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.just.enable {
    home.packages = with pkgs; [ just ];

    home.shellAliases = {
      j = "just";
    };
  };
}
