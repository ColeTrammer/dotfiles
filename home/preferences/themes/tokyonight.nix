{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    preferences.themes.tokyonight = {
      enable = lib.mkEnableOption "tokyonight" // {
        default = config.preferences.enable;
      };
      default = lib.mkEnableOption "use tokyonight by default" // {
        default = false;
      };
      variant = lib.mkOption {
        type = lib.types.str;
        default = "night";
        description = ''Color scheme variant'';
      };
    };
  };

  config =
    let
      tokyonightPlugin = pkgs.vimPlugins.tokyonight-nvim;
      variant = config.preferences.themes.tokyonight.variant;
      enable = config.preferences.themes.tokyonight.enable;
      default = config.preferences.themes.tokyonight.default;
      desktop = config.preferences.enableDesktopTheme && default;
    in
    lib.mkIf enable {
      # Bat
      programs.bat = {
        config = lib.mkIf default { theme = "tokyonight"; };
        themes = {
          "tokyonight" = {
            src = "${tokyonightPlugin}/extras/sublime/tokyonight_${variant}.tmTheme";
          };
        };
      };

      # Delta
      programs.git = lib.mkIf default {
        delta.options.syntax-theme = "tokyonight";
        extraConfig.include.path = [ "${config.xdg.configHome}/delta/tokyonight.gitconfig" ];
      };
      xdg.configFile."delta/tokyonight.gitconfig".source =
        "${tokyonightPlugin}/extras/delta/tokyonight_${variant}.gitconfig";

      # Fzf
      programs.bash.initExtra = lib.mkIf default (
        lib.mkOrder 0 "source ${config.xdg.configHome}/fzf/tokyonight.sh"
      );
      programs.zsh.initExtraFirst = lib.mkIf default (
        lib.mkOrder 0 "source ${config.xdg.configHome}/fzf/tokyonight.sh"
      );
      xdg.configFile."fzf/tokyonight.sh".source =
        "${tokyonightPlugin}/extras/fzf/tokyonight_${variant}.zsh";

      programs.nixvim = lib.mkIf default {
        colorschemes.tokyonight = {
          enable = true;
          style = "night";
        };
      };

      # Tmux
      programs.tmux.plugins = lib.mkIf default (
        lib.mkOrder 0 [
          (pkgs.tmuxPlugins.mkTmuxPlugin {
            pluginName = "tokyonight";
            src = pkgs.writeShellScriptBin "tokyonight.tmux" ''
              tmux source ${tokyonightPlugin}/extras/tmux/tokyonight_${variant}.tmux
            '';
            version = "${tokyonightPlugin.version}";
            rtpFilePath = "bin/tokyonight.tmux";
            unpack = false;
          })
        ]
      );

      # Alacritty
      programs.alacritty.settings.import = lib.mkIf default (
        lib.mkOrder 0 [ "${config.xdg.configHome}/alacritty/tokyonight.toml" ]
      );
      xdg.configFile."alacritty/tokyonight.toml".source =
        "${tokyonightPlugin}/extras/alacritty/tokyonight_${variant}.toml";

      # Kitty
      programs.kitty.theme = lib.mkIf default "Tokyo Night";

      # Ghostty
      apps.ghostty.theme = lib.mkIf default "tokyonight";

      # Wezterm
      apps.wezterm.colorscheme = lib.mkIf default "tokyonight_night";
      home.file.".config/wezterm/tokyonight.toml".source =
        "${pkgs.vimPlugins.tokyonight-nvim}/extras/wezterm/tokyonight_night.toml";

      # GTK
      gtk = lib.mkIf desktop {
        theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
        };

        iconTheme = {
          package = pkgs.gnome.adwaita-icon-theme;
          name = "MoreWaita";
        };
      };
      home.file.".local/share/themes/adw-gtk3-dark" = {
        source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark";
      };

      # QT
      home.packages =
        with pkgs;
        lib.mkIf desktop [
          qt5.qtwayland
          qt6.qtwayland
          qt6Packages.qtstyleplugin-kvantum
          libsForQt5.qtstyleplugin-kvantum
          libsForQt5.qt5ct
          breeze-icons
        ];
      qt = lib.mkIf desktop {
        enable = true;
        platformTheme.name = "qtct";
        style = {
          name = "kvantum";
        };
      };
    };
}
