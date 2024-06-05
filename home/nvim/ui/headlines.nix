{
  programs.nixvim = {
    plugins.headlines = let
      highlights = [
        "Headline1"
        "Headline2"
        "Headline3"
        "Headline4"
        "Headline5"
        "Headline6"
      ];
    in {
      enable = true;
      settings = {
        markdown = {
          headline_highlights = highlights;
          bullets = false;
        };
        norg = {
          headline_highlights = highlights;
          bullets = false;
        };
        rmd = {
          headline_highlights = highlights;
          bullets = false;
        };
        org = {
          headline_highlights = highlights;
          bullets = false;
        };
      };
    };
  };
}
