{pkgs, ...}: {
  home.packages = with pkgs; [
    steam-run
    gamescope
    mangohud
    gamemode
  ];

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        directory = ".local/share/Celeste";
        method = "symlink";
      }
    ];
  };
}
