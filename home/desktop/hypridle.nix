{
  config,
  inputs,
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
  imports = [
    inputs.hypridle.homeManagerModules.default
  ];

  services.hypridle = {
    enable = true;
    beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
    afterSleepCmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
    lockCmd = "${pkgs.procps}/bin/pidof hyprlock || ${lib.getExe config.programs.hyprlock.package}";

    listeners = [
      {
        timeout = 300;
        onTimeout = "${onlyIfNoAudio} ${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        timeout = 380;
        onTimeout = "${onlyIfNoAudio} ${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 1800;
        onTimeout = "${onlyIfNoAudio} ${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
