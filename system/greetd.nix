{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --asterisks \
            --user-menu \
            --cmd Hyprland
        '';
        user = "greeter";
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
