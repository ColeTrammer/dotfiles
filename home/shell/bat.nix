{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight";
    };
    themes = {
      tokyonight = {
        src = "${pkgs.vimPlugins.tokyonight-nvim}/extras/sublime/tokyonight_night.tmTheme";
      };
    };
    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };

  home.shellAliases = {
    cat = "bat";
    man = "batman";
  };

  home.sessionVariables = {
    PAGER = "bat";
  };
}
