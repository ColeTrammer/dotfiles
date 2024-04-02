{
  config,
  inputs,
  lib,
  ...
}: {
  nix = {
    settings = lib.mkMerge [
      {
        experimental-features = ["nix-command" "flakes" "repl-flake"];
        warn-dirty = false;
        auto-optimise-store = true;
      }
      (lib.mkIf config.hyprland.enable
        {
          substituters = ["https://hyprland.cachix.org"];
          trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        })
    ];

    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = ["nixpkgs=flake:nixpkgs"];

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
