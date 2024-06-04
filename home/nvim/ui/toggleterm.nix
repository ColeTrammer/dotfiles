{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        # This is binding to control+/.
        open_mapping = "[[<c-_>]]";
        shade_terminals = false;
      };
    };
  };
}
