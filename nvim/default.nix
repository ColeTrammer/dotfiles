{ config, pkgs, ... }:

{
  config = {
    # Neovim using home manager
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        python3
        gnumake
        nodejs_21
        cargo
        unzip
        gcc
      ];
    };

    # Out of store symlink so config is modifiable.
    xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/Workspace/nix/dotfiles/nvim";
  };
}
