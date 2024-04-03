{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../..
  ];

  home = {
    username = "colet";
    homeDirectory = "/home/colet";
    stateVersion = "23.11";
  };

  apps.enable = true;
  desktop.enable = true;

  nixpkgs.config.allowUnfree = true;
}
