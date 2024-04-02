{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./cursor.nix
    ./gammastep.nix
    ./gpg.nix
    ./gtk.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./keyring.nix
    ./mako.nix
    ./qt.nix
    ./rofi.nix
    ./udiskie.nix
    ./warp.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Desktop Environment";
  };

  config = lib.mkIf config.desktop.enable {
    home.packages = with pkgs; [
      playerctl
      xdg-utils
      xwaylandvideobridge
    ];
  };
}
