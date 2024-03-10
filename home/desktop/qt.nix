{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = "gtk3";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
