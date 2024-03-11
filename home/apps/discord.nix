{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
  ];

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      {
        directory = ".config/discord";
        method = "symlink";
      }
    ];
  };
}
