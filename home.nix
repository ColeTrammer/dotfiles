{ inputs, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./git.nix
    ./nvim
    ./kitty.nix
    ./tmux.nix
  ];

  home.username = "colet";
  home.homeDirectory = "/home/colet";

  home.stateVersion = "23.11";

  # Packages
  home.packages = with pkgs; [
    fd
    discord
    spotify
    wl-clipboard
  ];

  # Bash
  programs.bash.enable = true;
  programs.bash.historyFileSize = 1000000;
  programs.bash.historySize = 1000000;
  programs.bash.initExtra = ''
    export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
  '';

  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    enableAliases = true;
    extraOptions = [
      "--group-directories-first"
      "--hyperlink"
    ];
  };
  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      cmd_duration.disabled = true;
    };
  };
  programs.zoxide.enable = true;

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    size = 32;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita Dark";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk3";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        "DP-1, 3840x2160, 0x0, 1.5"
        "DP-2, 3840x2160, 2560x0, 1.5"
      ];
      xwayland = {
        force_zero_scaling = true;
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };
      misc = {
        disable_splash_rendering = true;
      };
      bind =
        [
          "$mod, return, exec, kitty"
          "$mod, D, exec, rofi -show drun"
          "$mod, O, exec, firefox"
          "$mod, Q, killactive,"
          "$mod, M, exit,"
          "$mod, V, togglefloating,"
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "tray"
        ];
      };
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "Fira Code Nerd Font";
    theme = "Arc-Dark";
  };

  services.mako = {
    enable = true;
  };

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;

  # Shell aliases.
  home.shellAliases = {
    cat = "bat";
    cd = "z";
  };

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  gpgKey = "60DCAA3C4B6F51E3";

  programs.firefox.enable = true;

  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Workspace"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        directory = ".local/share/Celeste";
        method = "symlink";
      }
      {
        directory = ".config/discord";
        method = "symlink";
      }
      {
        directory = ".config/spotify";
        method = "symlink";
      }
      ".local/state/nvim"
      ".local/share/nvim"
      ".local/share/zoxide"
      ".mozilla"
    ];
    files = [
      ".bash_history"
    ];
    allowOther = true;
  };

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
}
