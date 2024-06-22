{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    flake-root = {
      url = "github:srid/flake-root";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stickybuf-nvim = {
      url = "github:stevearc/stickybuf.nvim";
      flake = false;
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };

    catppuccin-bottom = {
      url = "github:catppuccin/bottom";
      flake = false;
    };

    catppuccin-delta = {
      url = "github:catppuccin/delta";
      flake = false;
    };

    catppuccin-palette = {
      url = "github:catppuccin/palette";
      flake = false;
    };

    catppuccin-zathura = {
      url = "github:catppuccin/zathura";
      flake = false;
    };

    catppuccin-zsh-fsh = {
      url = "github:catppuccin/zsh-fsh";
      flake = false;
    };

    lf = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    nvim-lazydev = {
      url = "github:folke/lazydev.nvim";
      flake = false;
    };
  };

  outputs =
    {
      flake-parts,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.flake-root.flakeModule
        hosts/flake-module.nix
        home/configurations/flake-module.nix
      ];

      perSystem =
        { config, pkgs, ... }:
        {
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;

            programs.nixfmt-rfc-style.enable = true;
            programs.prettier.enable = true;
            programs.shfmt.enable = true;
          };

          devShells.default = pkgs.mkShell {
            packages = [
              config.treefmt.build.wrapper
              pkgs.nodePackages_latest.npm
              pkgs.nodejs
            ] ++ builtins.attrValues config.treefmt.build.programs;
          };
        };
    };
}
