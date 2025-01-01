{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.ghostty = {
      enable = lib.mkEnableOption "ghostty";
      enablePackage = lib.mkEnableOption "Install ghostty package" // {
        default = config.apps.ghostty.enable && config.preferences.os == "linux";
      };
      theme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-mocha";
        description = "Ghostty theme";
      };
      windowDecorations = lib.mkEnableOption "Enable window decorations for ghostty" // {
        default = config.preferences.os != "linux";
      };
    };
  };

  config =
    let
      keyValueSettings = {
        listsAsDuplicateKeys = true;
        mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
      };
      linuxBinds = [
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+shift+a=select_all"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+n=new_window"
        "ctrl+shift+f=toggle_fullscreen"
        "ctrl+shift+q=close_all_windows"
        "ctrl+plus=increase_font_size:1"
        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"
      ];

      macBinds = [
        "command+v=paste_from_clipboard"
        "command+a=select_all"
        "command+c=copy_to_clipboard"
        "command+n=new_window"
        "command+f=toggle_fullscreen"
        "command+q=close_all_windows"
        "command+plus=increase_font_size:1"
        "command+equal=increase_font_size:1"
        "command+minus=decrease_font_size:1"
        "command+zero=reset_font_size"
      ];
      uiBinds = if config.preferences.os == "linux" then linuxBinds else macBinds;
      keyValue = pkgs.formats.keyValue keyValueSettings;
    in
    lib.mkIf config.apps.ghostty.enable {
      home.packages = lib.mkIf config.apps.ghostty.enablePackage [
        pkgs.ghostty
      ];

      xdg.configFile."ghostty/config".source = keyValue.generate "ghostty-config" {
        auto-update = "off";
        command = config.preferences.shell;

        font-family = [
          "\"\""
          config.preferences.font.name
        ];
        font-size = config.preferences.font.size;
        theme = config.apps.ghostty.theme;

        mouse-hide-while-typing = true;
        confirm-close-surface = false;
        window-decoration = config.apps.ghostty.windowDecorations;

        cursor-style-blink = false;
        adjust-cursor-thickness = 3;
        cursor-color = "#cccccc";
        cursor-text = "#111111";

        focus-follows-mouse = true;

        clipboard-read = "allow";
        clipboard-write = "allow";
        shell-integration-features = "no-cursor";

        macos-option-as-alt = true;

        keybind = [
          "clear"

          # Custom escape codes
          "ctrl+backspace=text:\\x17"
          "ctrl+enter=text:\\x1e"
          "shift+enter=text:\\x1d"
          "shift+backspace=text:\\x7f"
        ] ++ uiBinds;
      };
    };
}
