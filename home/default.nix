{...}: {
  imports = [
    ./apps
    ./desktop
    ./nvim
    ./preferences
    ./shell
  ];

  programs.home-manager.enable = true;
}
