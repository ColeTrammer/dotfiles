{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    shell.bat.enable =
      lib.mkEnableOption "bat"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.bat.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batman
      ];
    };

    home.shellAliases = {
      cat = "bat -p";
      man = "batman";
    };

    home.sessionVariables = {
      BAT_PAGER = "less";
    };
  };
}
