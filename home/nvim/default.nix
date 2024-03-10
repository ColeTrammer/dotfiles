{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    # Most of these packages are needed because the config still relies on Mason.
    # wl-clipboard however is needed for copy/paste to work on wayland desktops. 
    extraPackages = with pkgs; [
      python3
      gnumake
      nodejs_21
      cargo
      unzip
      gcc
      wl-clipboard
    ];
  };

  # Out of store symlink so config is modifiable.
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/Workspace/nix/dotfiles/home/nvim";

  # Persist nvim data. .local/share/nvim is only needed for the Lazy and Mason package managers.
  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".local/state/nvim"
      ".local/share/nvim"
    ];
  };
}
