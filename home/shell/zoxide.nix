{ config, lib, ... }:
{
  options = {
    shell.zoxide.enable = lib.mkEnableOption "zoxide" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.zoxide.enable {
    programs.zoxide = {
      enable = true;
    };

    home.shellAliases = {
      cd = "z";
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/zoxide";
          method = "symlink";
        }
      ];
    };
  };
}
