{...}: {
  programs.eza = {
    enable = true;
    extraOptions = [
      "--group-directories-first"
      "--hyperlink"
      "--icons"
      "--git"
      "--time-style=relative"
      "--header"
    ];
  };
}
