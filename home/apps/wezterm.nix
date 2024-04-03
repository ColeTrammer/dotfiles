{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    apps.wezterm.enable = lib.mkEnableOption "Wezterm";
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
          color_scheme = "tokyonight_night",
          scrollback_lines = 10000,
          default_prog = { '${config.preferences.shell}' },
          window_padding = {
            left = 4,
            right = 4,
            top = 16,
            bottom = 0,
          },
          keys = {
            { key = "Backspace", mods = "CTRL", action = act.SendKey({ key = "w", mods = "CTRL" }) },
            { key = "Enter", mods = "CTRL", action = act.SendKey({ key = "^", mods = "CTRL" }) },
            { key = "Enter", mods = "SHIFT", action = act.SendKey({ key = "^", mods = "CTRL" }) },
          },
        }
      '';
    };

    programs.bash.initExtra = lib.mkOrder 9999 ''
      source ${pkgs.wezterm}/etc/profile.d/wezterm.sh
    '';

    home.file.".config/wezterm/tokyonight.toml".source = "${pkgs.vimPlugins.tokyonight-nvim}/extras/wezterm/tokyonight_night.toml";
  };
}
