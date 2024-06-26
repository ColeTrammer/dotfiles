{ inputs, pkgs, ... }:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    ./audio.nix
    ./docker.nix
    ./docs.nix
    ./greetd.nix
    ./hyprland.nix
    ./i18n.nix
    ./impermenence.nix
    ./kdeconnect.nix
    ./keyring.nix
    ./network.nix
    ./nix.nix
    ./perf.nix
    ./plymouth.nix
    ./steam.nix
    ./udisks.nix
    ./warp.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    nix-ld
  ];

  programs.nano.enable = false;
  services.xserver.desktopManager.xterm.enable = false;
}
