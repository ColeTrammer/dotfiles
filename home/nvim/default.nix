{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./editor
    ./keymaps
    ./lang
    ./settings
    ./telescope
    ./ui
  ];

  options = {
    nvim.enable = lib.mkEnableOption "Neovim" // {default = true;};
  };

  config = lib.mkIf config.nvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      # wl-clipboard is required for copy/paste to work on wayland desktops.
      # ripgrep and find is used for search + telescope
      # nil and alejandra are installed so that we can setup nix dev environments while still having formatting + LSP.
      extraPackages = with pkgs; [
        wl-clipboard
        ripgrep
        fd
      ];
    };

    # Aliases
    home.shellAliases = {
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };
  };
}
