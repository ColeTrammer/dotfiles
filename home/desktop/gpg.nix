{ ... }:

{
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [ ".gnupg" ];
  };
}
