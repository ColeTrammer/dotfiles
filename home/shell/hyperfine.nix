{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.hyperfine.enable = lib.mkEnableOption "hyperfine" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.hyperfine.enable { home.packages = with pkgs; [ hyperfine ]; };
}
