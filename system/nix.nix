{ inputs, lib, ... }:
{
  nix = {
    settings = lib.mkMerge [
      {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
        auto-optimise-store = true;
      }
    ];

    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
