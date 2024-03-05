{ pkgs, ... }:

{
  config = {
    programs.kitty = {
      enable = true;
      font = {
        name = "Fira Code Nerd Font";
        package = pkgs.fira-code-nerdfont;
      };
      theme = "Tokyo Night";
      shellIntegration = {
        enableBashIntegration = true;
      };
    };
  };
}
