{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    useMkOutOfStoreSymlink = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''Use out of store symlink to link the config.'';
    };
  };

  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      # Node JS is required for GitHub copilot.
      # wl-clipboard is required for copy/paste to work on wayland desktops.
      # nil and alejandra are installed so that we can setup nix dev environments while still having formatting + LSP.
      extraPackages = with pkgs; [
        nodejs_21
        wl-clipboard
        nil
        alejandra
      ];
    };

    # Out of store symlink so config is modifiable.
    xdg.configFile.nvim.source =
      if config.useMkOutOfStoreSymlink
      then config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Workspace/nix/dotfiles/home/nvim"
      else ./.;

    # Persist nvim data. .local/share/nvim is only needed for the Lazy and Mason package managers.
    home.persistence."/persist/home" = {
      allowOther = true;
      directories = [
        ".local/state/nvim"
        ".local/share/nvim"
      ];
    };
  };
}
