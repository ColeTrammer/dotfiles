{ config, lib, ... }:
{
  options = {
    apps.kitty.enable = lib.mkEnableOption "Kitty";
  };

  config = lib.mkIf config.apps.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = config.preferences.font.name;
        package = config.preferences.font.package;
        size = config.preferences.font.size;
      };
      settings = {
        scrollback_lines = 100000;
        copy_on_select = "clipboard";
        cursor = "none";
        enable_audio_bell = false;
        strip_trailing_spaces = "never";
        focus_follows_mouse = "yes";
        mouse_hide_wait = 1;
        macos_option_as_alt = "yes";
        confirm_os_window_close = 0;
        placement_strategy = "top-left";
        clipboard_control = "write-primary write-clipboard no-append";
        shell = config.preferences.shell;
      };
      keybindings = {
        "ctrl+backspace" = "send_text all \\u001b[127;5u";
        "ctrl+enter" = "send_text all \\u001b[13;5u";
        "shift+enter" = "send_text all \\u001b[13;2u";
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
        mode = "no-cursor";
      };
    };
  };
}
