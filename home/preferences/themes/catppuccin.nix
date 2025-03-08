{
  config,
  helpers,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    preferences.themes.catppuccin = {
      enable = lib.mkEnableOption "catppuccin" // {
        default = config.preferences.enable;
      };
      default = lib.mkEnableOption "use catppuccin by default" // {
        default = false;
      };
      variant = lib.mkOption {
        type = lib.types.str;
        default = "mocha";
        description = ''Color scheme variant'';
      };
      accent = lib.mkOption {
        type = lib.types.str;
        default = "lavender";
        description = ''Color scheme accent'';
      };
    };
  };

  config =
    let
      accent = config.preferences.themes.catppuccin.accent;
      variant = config.preferences.themes.catppuccin.variant;
      enable = config.preferences.themes.catppuccin.enable;
      default = config.preferences.themes.catppuccin.default;
      desktop = config.preferences.enableDesktopTheme && default;

      accentUpperFirstLetter = builtins.substring 0 1 (lib.toUpper accent);
      accentLength = builtins.stringLength accent;
      accentRest = builtins.substring 1 (accentLength - 1) accent;
      accentTitleCase = accentUpperFirstLetter + accentRest;

      variantUpperFirstLetter = builtins.substring 0 1 (lib.toUpper variant);
      variantLength = builtins.stringLength variant;
      variantRest = builtins.substring 1 (variantLength - 1) variant;
      variantTitleCase = variantUpperFirstLetter + variantRest;

      colors = builtins.fromJSON (builtins.readFile "${inputs.catppuccin-palette}/palette.json");
      variantColors = colors.${variant}.colors;
      crustColorHex = variantColors.crust.hex;
      accentColorHex = variantColors.${accent}.hex;

      rgbColor = color: "rgb(${builtins.substring 1 (-1) color.hex})";
      rgbaColor =
        color: alphaHex: "rgba(${builtins.substring 1 (-1) color.hex}${builtins.toString alphaHex})";

      fzfColors = {
        bg = variantColors.base.hex;
        "bg+" = variantColors.surface0.hex;
        hl = variantColors.blue.hex; # Upstream uses red instead.
        "hl+" = variantColors.blue.hex; # Upstream uses red instead.
        fg = variantColors.text.hex;
        "fg+" = variantColors.text.hex;
        spinner = variantColors.rosewater.hex;
        header = variantColors.red.hex;
        info = variantColors.mauve.hex;
        pointer = variantColors.rosewater.hex;
        marker = variantColors.lavender.hex;
        prompt = variantColors.mauve.hex;
        selected-bg = variantColors.surface1.hex;
      };
      fzfColorOptions =
        fzfColors |> lib.attrsets.mapAttrsToList (n: v: "${n}:${v}") |> lib.strings.concatStringsSep ",";
      fzfOption = ''
        export FZF_DEFAULT_OPTS=" \
          --color=${fzfColorOptions} \
          --multi"
      '';
    in
    lib.mkIf enable {
      # Bat
      programs.bat = {
        config = lib.mkIf default { theme = "Catppuccin ${variantTitleCase}"; };
        themes = {
          "catppuccin" = {
            src = "${inputs.catppuccin-bat}/themes/Catppuccin ${variantTitleCase}.tmTheme";
          };
          "Catppuccin ${variantTitleCase}" = {
            src = "${inputs.catppuccin-bat}/themes/Catppuccin ${variantTitleCase}.tmTheme";
          };
        };
      };

      # Bottom
      programs.bottom.settings = lib.mkIf default (
        builtins.fromTOML (builtins.readFile "${inputs.catppuccin-bottom}/themes/${variant}.toml")
      );

      # Delta
      programs.git = {
        delta.options = lib.mkIf default { features = "catppuccin-${variant}"; };
        extraConfig.include.path = [ "${config.xdg.configHome}/delta/catppuccin.gitconfig" ];
      };
      xdg.configFile."delta/catppuccin.gitconfig".source =
        "${inputs.catppuccin-delta}/catppuccin.gitconfig";

      # Fzf
      programs.bash.initExtra = lib.mkIf default (
        lib.mkOrder 0 "source ${config.xdg.configHome}/fzf/catppuccin.sh"
      );
      programs.zsh.initExtraFirst = lib.mkIf default (
        lib.mkOrder 0 "source ${config.xdg.configHome}/fzf/catppuccin.sh"
      );
      xdg.configFile."fzf/catppuccin.sh".text = "${fzfOption}";

      # Neovim
      programs.nixvim = lib.mkIf default {
        colorschemes.catppuccin = {
          enable = true;
          lazyLoad.enable = true;
          settings = {
            flavour = variant;
            styles = {
              conditionals = [ "italic" ];
              loops = [ "italic" ];
            };
            custom_highlights = helpers.luaRawExpr ''
              return function(C)
                return {
                  BlinkCmpKind = { fg = C.blue },
                  BlinkCmpMenu = { fg = C.text },
                  BlinkCmpMenuBorder = { fg = C.blue },
                  BlinkCmpDocBorder = { fg = C.blue },
                  BlinkCmpSignatureHelpActiveParameter = { fg = C.mauve },
                }
              end
            '';
            integrations = {
              blink_cmp = true;
              diffview = true;
              fzf = true;
              noice = true;
              notify = true;
              overseer = true;
              harpoon = true;
              which_key = true;
              lsp_trouble = true;
              grug_far = true;
              native_lsp = {
                enabled = true;
                underlines = {
                  errors = [ "undercurl" ];
                  hints = [ "undercurl" ];
                  warnings = [ "undercurl" ];
                  information = [ "undercurl" ];
                };
              };
            };
          };
        };
        plugins.bufferline.settings.options.highlights.__raw =
          "require('catppuccin.groups.integrations.bufferline').get()";
      };

      # Tmux
      programs.tmux.plugins = lib.mkIf default (
        lib.mkOrder 0 [
          {
            plugin = pkgs.tmuxPlugins.catppuccin.overrideAttrs (x: {
              src = inputs.catppuccin-tmux;
              version = "0.3.0";
            });
            extraConfig = ''
              set -g @catppuccin_window_separator " "
              set -g @catppuccin_window_left_separator "█"
              set -g @catppuccin_window_right_separator "█"
              set -g @catppuccin_window_number_position "left"
              set -g @catppuccin_window_middle_separator "█ "
              set -g @catppuccin_window_status_enable "yes"
              set -g @catppuccin_window_status_icon_enable "yes"
              set -g @catppuccin_window_default_text "#{window_name}"
              set -g @catppuccin_window_current_text "#{window_name}"

              set -g @catppuccin_icon_window_last "󰖰 "
              set -g @catppuccin_icon_window_current "󰖯 "
              set -g @catppuccin_icon_window_zoom "󰁌 "
              set -g @catppuccin_icon_window_mark "󰃀 "
              set -g @catppuccin_icon_window_silent "󰂛 "
              set -g @catppuccin_icon_window_activity "󱅫 "
              set -g @catppuccin_icon_window_bell "󰂞 "

              set -g @catppuccin_pane_active_border_style "fg=${accentColorHex}"

              set -g @catppuccin_status_background "${crustColorHex}"
              set -g @catppuccin_status_modules_right "host session date_time"
              set -g @catppuccin_status_left_separator "█"
              set -g @catppuccin_status_right_separator "█"
              set -g @catppuccin_status_right_separator_inverse "no"
              set -g @catppuccin_status_fill "icon"
              set -g @catppuccin_date_time_text "%m-%d %H:%M:%S"
            '';
          }
        ]
      );

      # Yazi
      programs.yazi = {
        theme = {
          flavor = {
            use = "catppuccin-${variant}";
          };
        };
        flavors = {
          "catppuccin-${variant}" = "${inputs.yazi-flavors}/catppuccin-${variant}.yazi";
        };
      };

      # Zsh fast syntax highlighting
      programs.zsh.initExtra = lib.mkIf default (
        lib.mkOrder 1100 ''
          # Set syntax highlighting theme
          # This should be doable at build time, since this trys to write a default theme file...
          fast-theme XDG:catppuccin-${variant} >/dev/null 2>/dev/null
        ''
      );
      xdg.configFile."fsh".source = "${inputs.catppuccin-zsh-fsh}/themes";

      # Alacritty
      programs.alacritty.settings.general.import = lib.mkIf default (
        lib.mkOrder 0 [ "${config.xdg.configHome}/alacritty/catppuccin.toml" ]
      );
      xdg.configFile."alacritty/catppuccin.toml".source =
        "${inputs.catppuccin-alacritty}/catppuccin-${variant}.toml";

      # Kitty
      programs.kitty.themeFile = lib.mkIf default "Catppuccin-${variantTitleCase}";

      # Ghostty
      apps.ghostty.theme = lib.mkIf default "catppuccin-${variant}";
      xdg.configFile."ghostty/themes/catppuccin-${variant}".source =
        "${inputs.catppuccin-ghostty}/catppuccin-${variant}.conf";

      # Wezterm
      apps.wezterm.colorscheme = lib.mkIf default "Catppuccin ${variantTitleCase}";

      # Zathura
      xdg.configFile."zathura/catppuccin-${variant}".source =
        "${inputs.catppuccin-zathura}/src/catppuccin-${variant}";
      programs.zathura.extraConfig = lib.mkIf default ''
        include catppuccin-${variant}
      '';

      # Hyprland
      wayland.windowManager.hyprland.settings = lib.mkIf default {
        decoration = {
          shadow.color = rgbaColor variantColors.crust 99;
        };
        general = {
          "col.active_border" = rgbColor variantColors.mantle;
          "col.inactive_border" = rgbColor variantColors.crust;
        };
        group = {
          "col.border_active" = rgbColor variantColors.mantle;
          "col.border_locked_active" = rgbColor variantColors.mantle;
          "col.border_inactive" = rgbColor variantColors.crust;
          "col.border_locked_inactive" = rgbColor variantColors.crust;
          groupbar = {
            text_color = rgbColor variantColors.text;
            "col.active" = rgbColor variantColors.mantle;
            "col.locked_active" = rgbColor variantColors.mantle;
            "col.inactive" = rgbColor variantColors.base;
            "col.locked_inactive" = rgbColor variantColors.base;
          };
        };
        misc.background_color = rgbColor variantColors.crust;
      };

      # Cursor
      preferences.cursor = {
        package = pkgs.catppuccin-cursors.mochaDark;
        name = "catppuccin-${variant}-dark-cursors";
      };

      # GTK
      gtk = lib.mkIf desktop {
        theme = {
          # TODO: this theme is archived and will need to be replaced by something else.
          name = "catppuccin-${variant}-${accent}-standard+rimless";
          package = pkgs.catppuccin-gtk.override {
            accents = [ accent ];
            tweaks = [ "rimless" ];
            variant = variant;
          };
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.catppuccin-papirus-folders.override {
            flavor = variant;
            accent = accent;
          };
        };
      };
      xdg.configFile."gtk-4.0/assets" = lib.mkIf desktop {
        source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      };
      xdg.configFile."gtk-4.0/gtk.css" = lib.mkIf desktop {
        source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      };
      xdg.configFile."gtk-4.0/gtk-dark.css" = lib.mkIf desktop {
        source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      };

      # Qt
      home.packages =
        with pkgs;
        lib.mkIf desktop [
          (catppuccin-kvantum.override {
            accent = accent;
            variant = variant;
          })
          libsForQt5.qtstyleplugin-kvantum
          libsForQt5.qt5ct
          libsForQt5.qt5.qtwayland
          qt6Packages.qtstyleplugin-kvantum
          qt6Packages.qt6ct
          qt6.qtwayland
        ];
      qt = lib.mkIf desktop {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
      };
      xdg.configFile."Kvantum/kvantum.kvconfig" = lib.mkIf desktop {
        text = lib.generators.toINI { } {
          General = {
            theme = "Catppuccin-${variantTitleCase}-${accentTitleCase}";
          };
        };
      };
      xdg.configFile."qt5ct/qt5ct.conf" = lib.mkIf desktop {
        text = lib.generators.toINI { } {
          Appearance = {
            icon_theme = "Papirus-Dark";
          };
        };
      };
      xdg.configFile."qt6ct/qt6ct.conf" = lib.mkIf desktop {
        text = lib.generators.toINI { } {
          Appearance = {
            icon_theme = "Papirus-Dark";
          };
        };
      };
    };
}
