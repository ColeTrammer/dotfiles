{
  config,
  pkgs,
  ...
}: {
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
    config.lib.file.mkOutOfStoreSymlink
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
