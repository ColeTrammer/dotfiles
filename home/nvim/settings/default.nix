{
  programs.nixvim = {
    opts = {
      # Misc
      autoread = true;
      autowriteall = true;
      breakindent = true;
      confirm = true;
      cursorline = true;
      list = true;
      showmode = false;
      signcolumn = "yes";
      timeoutlen = 200;
      wrap = false;
      wildmode = "longest:full,full";

      # Undofile
      swapfile = false;
      undofile = true;
      undolevels = 10000;

      # Splits
      splitkeep = "screen";
      splitbelow = true;
      splitright = true;

      # Scroll context
      scrolloff = 4;
      sidescrolloff = 8;
      smoothscroll = true;

      # System clipboard integration
      clipboard = "unnamedplus";

      # Session
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";

      # Search
      ignorecase = true;

      # Status line always at bottom
      laststatus = 3;

      # Mouse
      mouse = "a";
      mousefocus = true;

      # Conceal
      conceallevel = 2;
      concealcursor = "nc";

      # Fold
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

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

    extraConfigLua = ''
      vim.opt.fillchars:append({ diff = "╱" })
    '';

    # Disable ruby provider
    globals.loaded_ruby_provider = 0;
  };
}
