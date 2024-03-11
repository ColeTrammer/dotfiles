{...}: {
  programs.firefox = {
    enable = true;
  };

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  home.persistence."/persist/home" = {
    allowOther = true;
    directories = [
      ".mozilla"
    ];
  };
}
