{
  config,
  lib,
  pkgs,
  ...
}: let
  onlyIfNoAudio = pkgs.writeShellScript "only-if-no-audio" ''
    ${pkgs.pipewire}/bin/pw-cli i all 2>&1 | ${pkgs.ripgrep}/bin/rg running -q
    if [ $? == 1 ]; then
      "$@"
    fi
  '';
in {
  options = {
    desktop.hypridle.enable =
      lib.mkEnableOption "Hypridle"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
          after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${lib.getExe config.programs.hyprlock.package}";
        };

        listeners = [
          {
            timeout = 300;
            on-timeout = "${onlyIfNoAudio} ${pkgs.systemd}/bin/loginctl lock-session";
          }
          {
            timeout = 380;
            on-timeout = "${onlyIfNoAudio} ${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
            onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "${onlyIfNoAudio} ${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
      };
    };
  };
}
