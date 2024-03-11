{inputs, ...}: {
  imports = [
    inputs.hyprlock.homeManagerModules.default
  ];

  programs.hyprlock = {
    enable = true;

    backgrounds = [
      {
        monitor = "";
        path = "";
        color = "rgba(0, 0, 0, 1)";
      }
    ];

    input-fields = [
      {
        monitor = "";
      }
    ];

    labels = [
      {
        monitor = "";
      }
    ];
  };
}
