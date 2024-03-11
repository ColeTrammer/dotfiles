{pkgs, ...}: {
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    size = 32;
    gtk.enable = true;
  };
}
