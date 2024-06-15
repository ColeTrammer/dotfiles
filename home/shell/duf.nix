{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.duf.enable = lib.mkEnableOption "duf" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.duf.enable {
    home.packages = with pkgs; [ duf ];

    home.shellAliases = {
      duf = "duf --theme ansi";
    };
  };
}
