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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs = {
    flake-parts,
    home-manager,
    nixpkgs,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
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

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        treefmt.config = {
          inherit (config.flake-root) projectRootFile;

          programs.alejandra.enable = true;
          programs.prettier.enable = true;
          programs.stylua.enable = true;
          programs.shfmt.enable = true;
        };

        devShells.default = pkgs.mkShell {
          packages =
            [
              config.treefmt.build.wrapper
              pkgs.nil
              pkgs.lua-language-server
              pkgs.marksman
              pkgs.markdownlint-cli
              pkgs.taplo
              pkgs.nodePackages_latest.npm
              pkgs.nodePackages_latest.typescript-language-server
              pkgs.nodejs
              (pkgs.writeShellScriptBin
                "vscode-json-language-server"
                ''${pkgs.nodePackages_latest.vscode-json-languageserver}/bin/vscode-json-languageserver "$@"'')
            ]
            ++ builtins.attrValues config.treefmt.build.programs;
        };
      };
    };
}
