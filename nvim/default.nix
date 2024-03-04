{ ... }:

{
  config = {
    # Neovim using home manager
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
    };

    # Lua config
    xdg.configFile.nvim.source = ./.;
  };
}
