{ pkgs, ... }:

{
  imports = [
    ./cursor.nix
    ./gammastep.nix
    ./gpg.nix
    ./gtk.nix
    ./hyprland.nix
    ./keyring.nix
    ./mako.nix
    ./qt.nix
    ./rofi.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    playerctl
    xwaylandvideobridge
  ];
}
