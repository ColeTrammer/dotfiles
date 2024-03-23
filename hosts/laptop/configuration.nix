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
  boot.loader.efi.canTouchEfiVariables = true;

  users.users."colet" = {
    isNormalUser = true;
    hashedPasswordFile = "/persist/secrets/passwords/colet";
    shell = pkgs.zsh;
    extraGroups = ["wheel" "docker"];
  };

  programs.zsh.enable = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "colet" = import ../../home/configurations/colet-laptop.nix;
    };
  };

  networking.hostName = "laptop";

  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
}
