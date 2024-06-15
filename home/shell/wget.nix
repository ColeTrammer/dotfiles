{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.wget.enable = lib.mkEnableOption "wget" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.wget.enable { home.packages = with pkgs; [ wget ]; };
}
