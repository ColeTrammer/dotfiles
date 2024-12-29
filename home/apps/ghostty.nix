{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.ghostty = {
      enable = lib.mkEnableOption "ghostty";
      theme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-mocha";
        description = "Ghostty theme";
      };
    };
  };

  config =
    let
      keyValueSettings = {
        listsAsDuplicateKeys = true;
        mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
      };
      keyValue = pkgs.formats.keyValue keyValueSettings;
    in
    lib.mkIf config.apps.ghostty.enable {
      home.packages = [
        inputs.ghostty.packages.${pkgs.system}.ghostty
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

        mouse-hide-while-typing = "true";
        confirm-close-surface = "false";
        window-decoration = "false";

        cursor-style-blink = "false";
        adjust-cursor-thickness = "3";
        cursor-color = "#cccccc";
        cursor-text = "#111111";

        focus-follows-mouse = "true";

        clipboard-read = "allow";
        clipboard-write = "allow";
        shell-integration-features = "no-cursor";

        macos-option-as-alt = "true";

        keybind = [
          "clear"

          # Custom escape codes
          "ctrl+backspace=text:\\x17"
          "ctrl+enter=text:\\x1e"
          "shift+enter=text:\\x1d"
          "shift+backspace=text:\\x7f"

          # UI
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+shift+a=select_all"
          "ctrl+plus=increase_font_size:1"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+n=new_window"
          "ctrl+minus=decrease_font_size:1"
          "ctrl+zero=reset_font_size"
        ];
      };
    };
}