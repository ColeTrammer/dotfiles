{
  config,
  lib,
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

  # We can't use lib.mkOutOfStoreSymlink because of a nix unstable issue.
  # see https://github.com/nix-community/home-manager/issues/4692
  home.activation = {
    updateLinks = ''
      export ROOT="${config.home.homeDirectory}/Workspace/nix/dotfiles"
      mkdir -p .config
      rm -f .config/nvim && ln -sf "$ROOT/home/nvim" .config/nvim
    '';
  };

  # Persist nvim data. .local/share/nvim is only needed for the Lazy and Mason package managers.
  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".local/state/nvim"
      ".local/share/nvim"
    ];
  };
}
