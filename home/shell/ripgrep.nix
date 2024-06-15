{ config, lib, ... }:
{
  options = {
    shell.ripgrep.enable = lib.mkEnableOption "ripgrep" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };
}
