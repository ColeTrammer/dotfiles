{
  programs.nixvim = {
    autoGroups = {
      checktime = {
        clear = true;
      };
      resize = {
        clear = true;
      };
      textfile = {
        clear = true;
      };
    };
    autoCmd = [
      {
        # Check for file modifications when reasonable.
        event = ["FocusGained" "TermClose" "TermLeave"];
        group = "checktime";
        callback.__raw = ''
          function()
            if vim.o.buftype ~= "nofile" then
              vim.cmd("checktime")
            end
          end
        '';
      }
      {
        # Resize window splits when resized.
        event = ["VimResized"];
        group = "resize";
        callback.__raw = ''
          function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd("tabnext " .. current_tab)
          end
        '';
      }
      {
        # Enable spell checking and word wrap for text files
        event = ["FileType"];
        pattern = ["*.txt" "*.tex" "*.typ" "gitcommit" "markdown" "norg" "COMMIT_EDITMSG"];
        group = "textfile";
        callback.__raw = ''
          function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end
        '';
      }
    ];
  };
}
