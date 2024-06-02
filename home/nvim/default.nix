{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./autocommands
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

      # Trying out the experimental lua loader.
      luaLoader.enable = true;

      # wl-clipboard is required for copy/paste to work on wayland desktops.
      # ripgrep and find is used for search + telescope
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
