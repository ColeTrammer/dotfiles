{ inputs, pkgs, ... }:

{
  imports = [
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    ./audio.nix
    ./greetd.nix
    ./geoclue.nix
    ./hyprland.nix
    ./i18n.nix
    ./impermenence.nix
    ./keyring.nix
    ./network.nix
    ./nix.nix
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    ntfs3g
  ];

  programs.nano.enable = false;
  services.xserver.desktopManager.xterm.enable = false;
}
