{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options = {
    nvim = {
      enable =
        lib.mkEnableOption "nvim"
        // {
          default = true;
        };
    };
  };

  config = lib.mkIf config.nvim.enable {
    nixpkgs = {
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
    };

    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      # wl-clipboard is required for copy/paste to work on wayland desktops.
      # nil and alejandra are installed so that we can setup nix dev environments while still having formatting + LSP.
      extraPackages = with pkgs; [
        wl-clipboard
        nil
        alejandra
      ];
    };

    # We can't use lib.mkOutOfStoreSymlink because of a nix unstable issue.
    # see https://github.com/nix-community/home-manager/issues/4692
    home.activation = {
      updateLinks = ''
        export ROOT="${config.preferences.dotfilesPath}"
        mkdir -p .config
        rm -f .config/nvim && ln -sf "$ROOT/home/nvim" .config/nvim
      '';
    };

    # Persist nvim data. .local/share/nvim is only needed for the Lazy and Mason package managers.
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
