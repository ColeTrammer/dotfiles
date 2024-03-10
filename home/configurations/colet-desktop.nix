{ ... }:

{
  imports = [
    ../default.nix
    ../apps
    ../desktop
  ];

  home.username = "colet";
  home.homeDirectory = "/home/colet";

  home.stateVersion = "23.11";

  gpgKey = "60DCAA3C4B6F51E3";

  nixpkgs.config.allowUnfree = true;
}
