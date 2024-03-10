{ ... }:

{
  services.gammastep = {
    enable = true;
    tray = true;
    temperature = {
      day = 5500;
      night = 3700;
    };
    provider = "geoclue2";
    settings = {
      general = {
        fade = 1;
        adjustment-method = "wayland";
      };
    };
  };
}
