{inputs, ...}: {
  imports = [
    (import ../../system/btrfs-luks.nix {device = "/dev/nvme0n1";})
    ./hardware-configuration.nix
    ../../system
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users."colet" = {
    isNormalUser = true;
    hashedPasswordFile = "/persist/secrets/passwords/colet";
    extraGroups = ["wheel"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "colet" = import ../../home/configurations/colet-desktop.nix;
    };
  };

  networking.hostName = "desktop";

  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
}
