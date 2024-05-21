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

  apps = {
    enable = true;
    obs.enable = true;
    steam.enable = true;
    vscode.enable = true;
  };

  desktop.enable = true;
  shell.git.gpgKey = "60DCAA3C4B6F51E3";

  nixpkgs.config.allowUnfree = true;
}
