{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../default.nix
    ../apps
    ../desktop
    ../shell/git.nix
  ];

  home.username = "colet";
  home.homeDirectory = "/home/colet";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
}
