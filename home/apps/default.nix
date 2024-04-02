{lib, ...}: {
  imports = [
    ./alacritty.nix
    ./discord.nix
    ./firefox.nix
    ./kitty.nix
    ./spotify.nix
    ./steam.nix
    ./vscode.nix
    ./wezterm.nix
  ];

  options = {
    apps.enable =
      lib.mkEnableOption "GUI Applications"
      // {
        default = false;
      };
  };
}
