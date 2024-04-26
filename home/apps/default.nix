{lib, ...}: {
  imports = [
    ./alacritty.nix
    ./discord.nix
    ./firefox.nix
    ./kitty.nix
    ./spotify.nix
    ./steam.nix
    ./vlc.nix
    ./vscode.nix
    ./wezterm.nix
  ];

  options = {
    apps.enable =
      lib.mkEnableOption "GUI Applications";
  };
}
