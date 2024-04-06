{
  config,
  lib,
  ...
}: {
  options = {
    shell.pistol.enable =
      lib.mkEnableOption "pistol"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.pistol.enable {
    programs.pistol = {
      enable = true;
      associations = [
        {
          mime = "application/json";
          command = "${config.preferences.pager} %pistol-filename%";
        }
        {
          mime = "text/*";
          command = "${config.preferences.pager} %pistol-filename%";
        }
      ];
    };
  };
}
