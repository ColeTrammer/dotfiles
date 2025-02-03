{ inputs, lib, ... }:
{
  nix = {
    settings = lib.mkMerge [
      {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        warn-dirty = false;
        auto-optimise-store = true;
        trusted-users = [ "colet" ];
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
