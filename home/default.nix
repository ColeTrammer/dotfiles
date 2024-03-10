{ inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./nvim
    ./shell
  ];

  home.persistence."/persist/home" = {
    directories = [
      ".cache"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Workspace"
    ];
    allowOther = true;
  };

  programs.home-manager.enable = true;
}
