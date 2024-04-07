{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  options = {
    ags = {
      enable =
        lib.mkEnableOption "ags"
        // {
          default = config.desktop.enable;
        };
    };
  };

  config = lib.mkIf config.ags.enable {
    programs.ags = {
      enable = true;
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        ".config/ags"
      ];
    };
  };
}
