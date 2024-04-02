{
  config,
  lib,
  ...
}: {
  options = {
    keyring.enable = lib.mkEnableOption "Gnome keyring" // {default = true;};
  };

  config = lib.mkIf config.keyring.enable {
    security.pam.services.login.enableGnomeKeyring = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
