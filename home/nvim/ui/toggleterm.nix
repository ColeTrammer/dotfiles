{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        # This is binding to control+/.
        open_mapping = "[[<c-_>]]";
        shade_terminals = false;
        size = 18;
        on_create = ''
          function()
            vim.cmd([[ setlocal signcolumn=no ]])
          end
        '';
      };
    };
  };
}
