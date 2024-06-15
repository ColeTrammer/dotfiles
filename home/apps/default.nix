{ lib, ... }:
{
  imports = [
    ./alacritty.nix
    ./discord.nix
    ./firefox.nix
    ./kitty.nix
    ./obs.nix
    ./spotify.nix
    ./steam.nix
    ./vlc.nix
    ./vscode.nix
    ./wezterm.nix
    ./zathura.nix
  ];

  options = {
    apps.enable = lib.mkEnableOption "GUI Applications";
  };
}
