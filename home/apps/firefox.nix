{
  config,
  lib,
  ...
}: {
  options = {
    apps.firefox.enable =
      lib.mkEnableOption "Firefox"
      // {
        default = config.apps.enable;
      };
  };

  config = lib.mkIf config.apps.firefox.enable {
    programs.firefox = {
      enable = true;
    };

    home.sessionVariables = {
      BROWSER = "firefox";
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        ".mozilla"
      ];
    };
  };
}
