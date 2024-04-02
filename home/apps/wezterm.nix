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
      extraConfig = builtins.readFile ./wezterm.lua;
    };

    home.packages = with pkgs; [
      fira-code-nerdfont
    ];

    programs.bash.initExtra = lib.mkOrder 9999 ''
      source ${pkgs.wezterm}/etc/profile.d/wezterm.sh
    '';

    home.file.".config/wezterm/tokyonight.toml".source = "${pkgs.vimPlugins.tokyonight-nvim}/extras/wezterm/tokyonight_night.toml";
  };
}
