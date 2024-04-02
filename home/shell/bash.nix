{
  config,
  lib,
  ...
}: {
  options = {
    shell.bash.enable =
      lib.mkEnableOption "bash"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.bash.enable {
    programs.bash = {
      enable = true;
      historyFileSize = 1000000;
      historySize = 1000000;
      initExtra = ''
        export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
        set -o vi
      '';
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      files = [
        ".bash_history"
      ];
    };
  };
}
