{ pkgs, ... }:

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
        nodejs_21
        cargo
        unzip
        gcc
      ];
    };

    # Lua config
    xdg.configFile.nvim.source = ./.;
  };
}
