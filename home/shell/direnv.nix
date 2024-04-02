{
  config,
  lib,
  ...
}: {
  options = {
    shell.direnv.enable =
      lib.mkEnableOption "direnv"
      // {
        default = config.shell.enable;
      };
  };

  config = lib.mkIf config.shell.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [".local/share/direnv"];
    };
  };
}
