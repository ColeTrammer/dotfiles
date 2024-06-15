{ config, lib, ... }:
{
  options = {
    shell.eza.enable = lib.mkEnableOption "eza" // {
      default = config.shell.enable;
    };
  };

  config = lib.mkIf config.shell.eza.enable {
    programs.eza = {
      enable = true;
      extraOptions = [
        "--group-directories-first"
        "--hyperlink"
        "--icons"
        "--git"
        "--time-style=relative"
        "--header"
      ];
    };

    programs.bash.initExtra = "unset LS_COLORS";
    programs.zsh.initExtra = "unset LS_COLORS";
  };
}
