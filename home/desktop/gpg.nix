{pkgs, ...}: {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [".gnupg"];
  };
}
