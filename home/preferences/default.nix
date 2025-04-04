{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    preferences = {
      enable = lib.mkEnableOption "preferences" // {
        default = true;
      };
      enableDesktopTheme = lib.mkEnableOption "desktop theme" // {
        default = config.desktop.enable;
      };
      enableTerminal = lib.mkEnableOption "terminal" // {
        default = config.apps.enable;
      };
      enableDocumentViewer = lib.mkEnableOption "document viewer" // {
        default = config.apps.enable;
      };

      os = lib.mkOption {
        type = lib.types.str;
        default = builtins.head (builtins.tail (builtins.tail (builtins.split "-" (pkgs.system))));
        description = ''Operating system'';
      };

      theme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin";
        description = ''Default theme'';
      };

      prompt = lib.mkOption {
        type = lib.types.str;
        default = "oh-my-posh";
        description = ''Shell prompt to use (starship or oh-my-posh)'';
      };

      workspacePath = lib.mkOption {
        type = lib.types.path;
        default = "${config.home.homeDirectory}/Workspace";
        description = ''Path to coding workspace.'';
      };

      dotfilesPath = lib.mkOption {
        type = lib.types.path;
        default = "${config.preferences.workspacePath}/nix/dotfiles";
        description = ''Path to dotfiles source.'';
      };

      terminalFileManager = lib.mkOption {
        type = lib.types.str;
        default = "yazi";
        description = ''Terminal file manager.'';
        example = "lf";
      };

      pager = lib.mkOption {
        type = lib.types.str;
        default = "${pkgs.bat}/bin/bat --paging=always --color=always -p";
        description = ''Default terminal pager'';
      };

      shell = lib.mkOption {
        type = lib.types.str;
        default = "${pkgs.zsh}/bin/zsh";
        description = ''Default shell'';
      };

      terminal = lib.mkOption {
        type = lib.types.str;
        default = "ghostty";
        description = ''Default terminal'';
      };

      documentViewer = lib.mkOption {
        type = lib.types.str;
        default = "zathura";
        description = ''Default document viewer'';
      };

      editor = lib.mkOption {
        type = lib.types.str;
        default = "nvim";
        description = ''Default editor'';
      };

      previewer = lib.mkOption {
        type = lib.types.path;
        default = "${pkgs.pistol}/bin/pistol";
        description = ''Default terminal previewer'';
      };

      font = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.nerd-fonts.jetbrains-mono;
          description = ''Default font package'';
        };

        name = lib.mkOption {
          type = lib.types.str;
          default = "JetBrainsMono Nerd Font";
          description = ''Default font name'';
        };

        size = lib.mkOption {
          type = lib.types.float;
          default = 12.0;
          description = ''Default font size'';
        };
        size_int = lib.mkOption {
          type = lib.types.int;
          default = 12;
          description = ''Default font size (as int)'';
        };
      };

      cursor = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.phinger-cursors;
          description = ''Default cursor package'';
        };

        name = lib.mkOption {
          type = lib.types.str;
          default = "phinger-cursors";
          description = ''Default cursor theme'';
        };

        size = lib.mkOption {
          type = lib.types.int;
          default = 32;
          description = ''Default cursor size'';
        };
      };
    };
  };

  config = lib.mkIf config.preferences.enable {
    # Env
    home.sessionVariables = {
      EDITOR = lib.mkForce config.preferences.editor;
      PAGER = config.preferences.pager;
    };

    # Fonts
    home.packages = lib.mkIf (
      config.preferences.enableDesktopTheme || config.preferences.enableTerminal
    ) [ config.preferences.font.package ];
    fonts.fontconfig.enable = config.preferences.enableDesktopTheme;

    # Terminal
    apps.${config.preferences.terminal}.enable = true;

    # Shell Prompt
    shell.${config.preferences.prompt}.enable = true;

    # Terminal File Manager
    shell.${config.preferences.terminalFileManager}.enable = true;

    # Document viewer
    apps.${config.preferences.documentViewer}.enable = true;
    xdg.mimeApps = {
      defaultApplications."application/pdf" = [ "${config.preferences.documentViewer}.desktop" ];
    };

    # Cursor
    home.pointerCursor = lib.mkIf config.preferences.enableDesktopTheme {
      package = config.preferences.cursor.package;
      name = config.preferences.cursor.name;
      size = config.preferences.cursor.size;
      hyprcursor.enable = true;
      gtk.enable = true;
    };

    # GTK dark mode
    gtk = lib.mkIf config.preferences.enableDesktopTheme {
      enable = true;

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
    dconf.settings = lib.mkIf config.preferences.enableDesktopTheme {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    # Custom nix theme
    preferences.themes.${config.preferences.theme} = {
      enable = true;
      default = true;
    };
  };
}
