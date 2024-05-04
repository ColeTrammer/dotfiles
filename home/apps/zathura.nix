{
  config,
  lib,
  ...
}: {
  options = {
    apps.zathura.enable =
      lib.mkEnableOption "Zathura";
  };

  config = lib.mkIf config.apps.zathura.enable {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
        window-title-home-tilde = true;
        statusbar-home-tilde = true;
        incremental-search = true;
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 1;
        adjust-open = "best-fit";
        font = "${config.preferences.font.name} ${builtins.toString config.preferences.font.size}";
      };
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/zathura";
          method = "symlink";
        }
      ];
    };
  };
}
