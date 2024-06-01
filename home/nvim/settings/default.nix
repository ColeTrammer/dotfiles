{
  programs.nixvim = {
    opts = {
      # Misc
      autowriteall = true;
      breakindent = true;
      confirm = true;
      cursorline = true;
      list = true;
      showmode = false;
      signcolumn = "yes";
      timeoutlen = 200;
      wrap = false;
      wildmode = "longest,full";

      # Undofile
      swapfile = false;
      undofile = true;
      undolevels = 10000;

      # Splits
      splitkeep = "screen";
      splitbelow = true;
      splitright = true;

      # Text width
      textwidth = 120;

      # Scroll context
      scrolloff = 4;
      sidescrolloff = 8;
      smoothscroll = true;

      # System clipboard integration
      clipboard = "unnamedplus";

      # Search
      ignorecase = true;

      # Status line always at bottom
      laststatus = 3;

      # Mouse
      mouse = "a";
      mousefocus = true;

      # Indent
      expandtab = true;
      shiftround = true;
      shiftwidth = 4;
      softtabstop = 4;
      tabstop = 4;

      # Relative line numbers
      number = true;
      relativenumber = true;
    };
  };
}
