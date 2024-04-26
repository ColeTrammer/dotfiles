{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    (import ../../system/btrfs-luks.nix {device = "/dev/nvme0n1";})
    ./hardware-configuration.nix
    ../../system
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;

  users.users."colet" = {
    isNormalUser = true;
    hashedPasswordFile = "/persist/secrets/passwords/colet";
    shell = pkgs.zsh;
    extraGroups = ["wheel" "docker"];
  };

  programs.zsh.enable = true;
  steam.enable = true;
  docker.enable = true;

  plymouth.dpi = 2.0;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "colet" = import (../../home/configurations/x86_64-linux + "/colet@desktop.nix");
    };
  };

  networking.hostName = "desktop";

  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
}
