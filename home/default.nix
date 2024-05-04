{...}: {
  imports = [
    ./apps
    ./desktop
    ./nvim
    ./preferences
    ./shell
  ];

  home.persistence."/persist/home" = {
    directories = [
      ".cache"
      {
        directory = ".ccache";
        method = "symlink";
      }
      {
        directory = "Downloads";
        method = "symlink";
      }
      {
        directory = "Music";
        method = "symlink";
      }
      {
        directory = "Pictures";
        method = "symlink";
      }
      {
        directory = "Documents";
        method = "symlink";
      }
      {
        directory = "Videos";
        method = "symlink";
      }
      {
        directory = "Workspace";
        method = "symlink";
      }
    ];
    allowOther = true;
  };

  programs.home-manager.enable = true;
}
