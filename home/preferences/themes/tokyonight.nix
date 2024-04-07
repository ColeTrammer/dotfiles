{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    preferences.themes.tokyonight = {
      enable = lib.mkEnableOption "tokyonight" // {default = true;};
      default = lib.mkEnableOption "use tokyonight by default" // {default = false;};
      variant = lib.mkOption {
        type = lib.types.str;
        default = "night";
        description = ''Color scheme variant'';
      };
    };
  };

  config = let
    tokyonightPlugin = pkgs.vimPlugins.tokyonight-nvim;
    variant = config.preferences.themes.tokyonight.variant;
    enable = config.preferences.themes.tokyonight.enable;
    default = config.preferences.themes.tokyonight.default;
  in
    lib.mkIf enable {
      # Bat
      programs.bat = {
        config = lib.mkIf default {
          theme = "tokyonight";
        };
        themes = {
          "tokyonight" = {
            src = "${tokyonightPlugin}/extras/sublime/tokyonight_${variant}.tmTheme";
          };
        };
      };

      # Delta
      programs.git = lib.mkIf default {
        delta.options.syntax-theme = "tokyonight";
        extraConfig.include.path = ["${config.xdg.configHome}/delta/tokyonight.gitconfig"];
      };
      xdg.configFile."delta/tokyonight.gitconfig".source = lib.mkIf enable "${tokyonightPlugin}/extras/delta/tokyonight_${variant}.gitconfig";

      # Fzf
      programs.bash.initExtra = lib.mkIf default (lib.mkOrder 0 "source ${config.xdg.configHome}/fzf/tokyonight.sh");
      programs.zsh.initExtraFirst = lib.mkIf default (lib.mkOrder 0 "source ${config.xdg.configHome}/fzf/tokyonight.sh");
      xdg.configFile."fzf/tokyonight.sh".source = lib.mkIf enable "${tokyonightPlugin}/extras/fzf/tokyonight_${variant}.zsh";

      # Tmux
      programs.tmux.plugins = lib.mkIf default (
        lib.mkOrder 0 [
          (pkgs.tmuxPlugins.mkTmuxPlugin
            {
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
      programs.alacritty.settings.import = lib.mkIf default (lib.mkOrder 0 [
        "${config.xdg.configHome}/alacritty/tokyonight.toml"
      ]);
      xdg.configFile."alacritty/tokyonight.toml".source =
        lib.mkIf enable
        "${tokyonightPlugin}/extras/alacritty/tokyonight_${variant}.toml";

      # Kitty
      programs.kitty.theme = lib.mkIf default "Tokyo Night";

      # Wezterm
      apps.wezterm.colorscheme = lib.mkIf default "tokyonight_night";
      home.file.".config/wezterm/tokyonight.toml".source = "${pkgs.vimPlugins.tokyonight-nvim}/extras/wezterm/tokyonight_night.toml";
    };
}
