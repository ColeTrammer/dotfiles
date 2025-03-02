{ config, lib, ... }:
{
  options = {
    apps.alacritty.enable = lib.mkEnableOption "Alacritty";
  };

  config = lib.mkIf config.apps.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 0;
            y = 0;
          };
          option_as_alt = "Both";
          decorations = "None";
        };
        font = {
          normal = {
            family = config.preferences.font.name;
            style = "Regular";
          };
          size = config.preferences.font.size;
        };
        scrolling = {
          history = 100000;
        };
        selection = {
          save_to_clipboard = true;
        };
        terminal = {
          osc52 = "CopyPaste";
          shell = config.preferences.shell;
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
              chars = "\\u001d";
            }
          ];
        };
      };
    };
  };
}
