{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${pkgs.vimPlugins.tokyonight-nvim}/extras/alacritty/tokyonight_night.toml"
      ];
      window = {
        padding = {
          x = 0;
          y = 4;
        };
      };
      font = {
        normal = {
          family = "Fira Code Nerd Font";
          style = "Regular";
        };
        size = 12.0;
      };
      mouse = {
        hide_when_typing = true;
      };
      keyboard = {
        bindings = [
          {
            key = "Backspace";
            mods = "Control";
            chars = "\\u0017";
          }
          {
            key = "Enter";
            mods = "Control";
            chars = "\\u001e";
          }
          {
            key = "Enter";
            mods = "Shift";
            chars = "\\u001e";
          }
        ];
      };
    };
  };
}
