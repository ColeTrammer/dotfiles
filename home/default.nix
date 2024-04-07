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
      ".ccache"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Workspace"
    ];
    allowOther = true;
  };

  programs.home-manager.enable = true;
}
