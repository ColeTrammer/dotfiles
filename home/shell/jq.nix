{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    shell.jq.enable =
      lib.mkEnableOption "jq"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.jq.enable {
    home.packages = with pkgs; [
      jq
    ];
  };
}
