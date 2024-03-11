{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [".local/share/direnv"];
  };
}
