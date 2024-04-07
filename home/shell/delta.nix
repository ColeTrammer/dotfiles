{
  config,
  lib,
  inputs,
  ...
}: {
  options = {
    shell.delta = {
      enable =
        lib.mkEnableOption "delta"
        // {
          default = config.shell.enable;
        };

      hyperlinks =
        lib.mkEnableOption "delta hyperlinks"
        // {
          default = true;
        };
    };
  };

  config = lib.mkIf config.shell.delta.enable {
    programs.git = {
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          hyperlinks = config.shell.delta.hyperlinks;
        };
      };
      extraConfig = {
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
      };
    };
  };
}
