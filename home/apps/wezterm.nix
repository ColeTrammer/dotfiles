{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.wezterm = {
      enable = lib.mkEnableOption "Wezterm";

      colorscheme = lib.mkOption {
        type = lib.types.str;
        default = "Catppuccin Mocha";
        description = ''colorscheme'';
      };
    };
  };

  config = lib.mkIf config.apps.wezterm.enable {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = false;
      extraConfig = ''
        local act = wezterm.action

        return {
          font = wezterm.font("${config.preferences.font.name}"),
          font_size = ${builtins.toString config.preferences.font.size},
          hide_tab_bar_if_only_one_tab = true,
          color_scheme = "${config.apps.wezterm.colorscheme}",
          scrollback_lines = 10000,
          default_prog = { '${config.preferences.shell}' },
          window_padding = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0,
          },
          keys = {
            { key = "Backspace", mods = "CTRL", action = act.SendString '\x1b[127;5u' },
            { key = "Enter", mods = "CTRL", action = act.SendString '\x1b[13;5u' },
            { key = "Enter", mods = "SHIFT", action = act.SendString '\x1b[13;2u' },
          },
        }
      '';
    };

    programs.bash.initExtra = lib.mkOrder 9999 ''
      source ${pkgs.wezterm}/etc/profile.d/wezterm.sh
    '';
  };
}
