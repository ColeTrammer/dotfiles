{
  config,
  lib,
  ...
}: {
  options = {
    shell.fzf.enable =
      lib.mkEnableOption "fzf"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.fzf.enable {
    programs.fzf = {
      enable = true;
    };
  };
}
