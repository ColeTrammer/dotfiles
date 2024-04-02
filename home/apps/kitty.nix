{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    apps.kitty.enable = lib.mkEnableOption "Kitty";
  };

  config = lib.mkIf config.apps.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        package = pkgs.fira-code-nerdfont;
        size = 12;
      };
      theme = "Tokyo Night";
      settings = {
        scrollback_lines = 10000;
        copy_on_select = "clipboard";
        cursor = "none";
        enable_audio_bell = false;
        update_check_interval = 0;
      };
      keybindings = {
        "ctrl+backspace" = "send_text \\u0017";
        "ctrl+enter" = "send_text \\u001e";
        "shift+enter" = "send_text \\u001e";
      };
      shellIntegration = {
        enableBashIntegration = true;
        mode = "no-cursor";
      };
    };
  };
}
