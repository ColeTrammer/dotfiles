{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options = {
    nvim.enable = lib.mkEnableOption "Neovim" // {
      default = true;
    };
  };

  config =
    let
      ts-overlay = final: prev: {
        tree-sitter =
          let
            version = "0.24.6";
            hash = "sha256-L7F2/S22knqEdB2hxfqLe5Tcgk0WQqBdFQ7BvHFl4EI=";
            cargoHash = "sha256-mk3aw1aFu7N+b4AQL5kiaHuIAuJv24KonFeGKid427Q=";
            src = prev.fetchFromGitHub {
              owner = "tree-sitter";
              repo = "tree-sitter";
              tag = "v${version}";
              inherit hash;
              fetchSubmodules = true;
            };
          in
          prev.tree-sitter.override {
            rustPlatform = prev.rustPlatform // {
              buildRustPackage =
                args:
                prev.rustPlatform.buildRustPackage (
                  args
                  // {
                    inherit version cargoHash src;
                  }
                );
            };
          };
      };
    in
    lib.mkIf config.nvim.enable {
      nixpkgs.overlays = [ ts-overlay ];

      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        # Trying out the experimental lua loader.
        luaLoader.enable = true;

        # wl-clipboard is required for copy/paste to work on wayland desktops.
        # ripgrep and find is used for search
        extraPackages = with pkgs; [
          wl-clipboard
          ripgrep
          fd
        ];
      };

      # Aliases
      home.shellAliases = {
        vimdiff = "nvim -d";
        dvim = "echo | nvim";
      };

      # Persist nvim data.
      home.persistence."/persist/home" = {
        allowOther = true;
        directories = [
          {
            directory = ".local/state/nvim";
            method = "symlink";
          }
          {
            directory = ".local/share/nvim";
            method = "symlink";
          }
        ];
      };
    };
}
