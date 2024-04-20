{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop.hyprland.enable =
      lib.mkEnableOption "Hyprland"
      // {
        default = config.desktop.enable;
      };
  };

  config = lib.mkIf config.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      settings = {
        "$mod" = "SUPER";
        monitor = [
          ",preferred,auto,1"
          "DP-1, 3840x2160, 0x0, 1.5"
          "DP-2, 3840x2160, 2560x0, 1.5"
        ];
        xwayland = {
          force_zero_scaling = true;
        };
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          kb_options = "caps:swapescape";
        };
        dwindle = {
          preserve_split = true;
        };
        misc = {
          disable_splash_rendering = true;
        };
        general = {
          gaps_in = 10;
          gaps_out = 14;
          border_size = 0;
        };
        decoration = {
          rounding = 10;

          drop_shadow = true;
          shadow_range = 30;
          shadow_render_power = 3;
          "col.shadow" = "0x66000000";

          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            new_optimizations = "on";
            noise = 0.01;
            contrast = 0.9;
            brightness = 0.8;
            popups = true;
          };
        };
        bind =
          [
            "$mod, return, exec, ${config.preferences.terminal}"
            "$mod, D, exec, rofi -show drun"
            "$mod, O, exec, firefox"
            "$mod, Q, killactive,"
            "$mod, W, exec, wlogout"
            "$mod, M, exit,"
            "$mod, V, togglefloating,"
            "$mod, Z, togglesplit,"
            "$mod, X, swapsplit,"
            "$mod, F, fullscreen,"
            "$mod, S, togglegroup,"
            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"
            "$mod CONTROL, N, changegroupactive, f"
            "$mod CONTROL, P, changegroupactive, b"
            "$mod CONTROL, L, lockactivegroup,"
            "$mod CONTROL, O, moveoutofgroup,"
            "$mod CONTROL, H, moveintogroup, l"
            "$mod CONTROL, J, moveintogroup, d"
            "$mod CONTROL, K, moveintogroup, u"
            "$mod CONTROL, L, moveintogroup, r"
          ]
          ++ (
            builtins.concatLists (builtins.genList
              (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                  "$mod CONTROL, ${ws}, changegroupactive, ${toString (x + 1)}"
                ]
              )
              10)
          );
        bindl = [
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bindle = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ];
        animations = {
          enabled = "yes";
          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
          ];
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
      };
      extraConfig = ''
        # window resize
        bind = $mod, R, submap, resize

        submap = resize
        binde = , l, resizeactive, 20 0
        binde = , h, resizeactive, -20 0
        binde = , k, resizeactive, 0 -20
        binde = , j, resizeactive, 0 20
        bind = , escape, submap, reset
        bind = $mod, c, submap, reset
        submap = reset
      '';
    };
  };
}
