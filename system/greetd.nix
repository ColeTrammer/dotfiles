{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    greetd.enable = lib.mkEnableOption "greetd and tuigreet" // {
      default = true;
    };
  };

  config = lib.mkIf config.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
              --time \
              --asterisks \
              --user-menu \
              --cmd Hyprland
          '';
          user = "greeter";
        };
      };
    };
    environment.etc."greetd/environments".text = ''
      Hyprland
    '';
  };
}
