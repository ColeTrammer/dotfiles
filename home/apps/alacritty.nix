{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    apps.alacritty.enable =
      lib.mkEnableOption "Alacritty"
      // {
        default = config.apps.enable;
      };
  };

  config = lib.mkIf config.apps.alacritty.enable {
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
            family = "FiraCode Nerd Font";
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
  };
}
