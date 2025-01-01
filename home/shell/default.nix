{ lib, ... }:
{
  options = {
    shell.enable = lib.mkEnableOption "Shell programs" // {
      default = true;
    };
  };
}
