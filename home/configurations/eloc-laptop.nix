{lib, ...}: {
  imports = [
    ../default.nix
    ../shell/git.nix
  ];

  options = {
    home.persistence = lib.mkOption {
      type = lib.types.anything;
    };
  };

  config = {
    home.username = "eloc";
    home.homeDirectory = "/home/eloc";

    home.stateVersion = "23.11";
  };
}
