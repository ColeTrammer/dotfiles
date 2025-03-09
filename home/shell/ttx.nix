{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.ttx.homeModules.default ];

  options = {
    shell.ttx = {
      enable = lib.mkEnableOption "ttx" // {
        default = config.shell.enable;
      };
    };
  };

  config = lib.mkIf config.shell.ttx.enable {
    programs.ttx = {
      enable = config.preferences.os == "linux";
      settings = {
        prefix = "A";
        shell = "${config.preferences.shell}";
      };
    };
  };
}
