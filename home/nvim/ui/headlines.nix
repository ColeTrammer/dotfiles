{
  programs.nixvim = {
    plugins.headlines =
      let
        highlights = [
          "Headline1"
          "Headline2"
          "Headline3"
          "Headline4"
          "Headline5"
          "Headline6"
        ];
      in
      {
        enable = true;
        settings = {
          markdown = {
            headline_highlights = highlights;
          };
          norg = {
            headline_highlights = highlights;
          };
          rmd = {
            headline_highlights = highlights;
          };
          org = {
            headline_highlights = highlights;
          };
        };
      };
  };
}
