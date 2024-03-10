{ pkgs, ... }:

{
  config = {
    programs.kitty = {
      enable = true;
      font = {
        name = "Fira Code Nerd Font";
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
      shellIntegration = {
        enableBashIntegration = true;
        mode = "no-cursor";
      };
    };
  };
}
