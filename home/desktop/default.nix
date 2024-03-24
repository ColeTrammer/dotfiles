{pkgs, ...}: {
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

  home.packages = with pkgs; [
    playerctl
    xdg-utils
    xwaylandvideobridge
  ];
}
