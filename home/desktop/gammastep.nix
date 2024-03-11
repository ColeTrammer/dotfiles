{...}: {
  services.gammastep = {
    enable = true;
    tray = true;
    temperature = {
      day = 5500;
      night = 3700;
    };
    latitude = 45.5;
    longitude = -122.7;
    settings = {
      general = {
        fade = 1;
        adjustment-method = "wayland";
      };
    };
  };
}
