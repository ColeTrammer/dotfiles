{ lib, ... }:
{
  options = {
    apps.enable = lib.mkEnableOption "GUI Applications";
  };
}
