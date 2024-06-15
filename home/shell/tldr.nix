{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.tldr.enable = lib.mkEnableOption "tldr" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.tldr.enable { home.packages = with pkgs; [ tlrc ]; };
}
