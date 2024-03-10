{ ... }:

{
  config = {
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
  };
}
