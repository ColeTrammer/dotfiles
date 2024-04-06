{
  config,
  lib,
  pkgs,
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
          syntax-theme = "tokyonight";
        };
      };
      extraConfig = {
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        include.path = "${pkgs.vimPlugins.tokyonight-nvim}/extras/delta/tokyonight_night.gitconfig";
      };
    };
  };
}
