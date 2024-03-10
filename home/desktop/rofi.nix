{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "Fira Code Nerd Font";
    theme = "Arc-Dark";
  };
}
