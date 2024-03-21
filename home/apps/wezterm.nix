{
  lib,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = false;
    extraConfig = ''
      return {
        font = wezterm.font("FiraCode Nerd Font"),
        font_size = 12.0,
        hide_tab_bar_if_only_one_tab = true,
        color_scheme = "tokyonight_night",
        scrollback_lines = 10000,
        window_padding = {
          left = 4,
          right = 4,
          top = 16,
          bottom = 0,
        },
      }
    '';
  };

  programs.bash.initExtra = lib.mkOrder 9999 ''
    source ${pkgs.wezterm}/etc/profile.d/wezterm.sh
  '';

  home.file.".config/wezterm/tokyonight.toml".source = "${pkgs.vimPlugins.tokyonight-nvim}/extras/wezterm/tokyonight_night.toml";
}
