{ config, lib, ... }:
{
  options = {
    shell.bottom.enable = lib.mkEnableOption "bottom" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.bottom.enable {
    programs.bottom = {
      enable = true;
    };
  };
}
