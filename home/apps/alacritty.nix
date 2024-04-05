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
        shell = config.preferences.shell;
        window = {
          padding = {
            x = 0;
            y = 0;
          };
        };
        font = {
          normal = {
            family = config.preferences.font.name;
            style = "Regular";
          };
          size = config.preferences.font.size;
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
