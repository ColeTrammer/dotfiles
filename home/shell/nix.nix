{ lib, pkgs, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      frequency = "daily";
      options = "--delete-older-than 7d";
    };
  };

  home.sessionVariables.NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
}
