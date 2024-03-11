{pkgs, ...}: {
  home.packages = with pkgs; [
    spotify
  ];

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      {
        directory = ".config/spotify";
        method = "symlink";
      }
    ];
  };
}
