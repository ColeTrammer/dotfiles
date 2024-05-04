{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./ags
    ./gammastep.nix
    ./kdeconnect.nix
    ./gpg.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./impermanence.nix
    ./keyring.nix
    ./rofi.nix
    ./udiskie.nix
    ./warp.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Desktop Environment";
  };

  config = lib.mkIf config.desktop.enable {
    home.packages = with pkgs; [
      playerctl
      xdg-utils
    ];
  };
}
