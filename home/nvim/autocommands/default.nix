{ helpers, ... }:
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
      normalMode = {
        clear = true;
      };
      formatopts = {
        clear = true;
      };
    };
    autoCmd = [
      {
        # Check for file modifications when reasonable.
        event = [
          "FocusGained"
          "TermClose"
          "TermLeave"
        ];
        group = "checktime";
        callback = helpers.luaRawExpr ''
          return function()
            if vim.o.buftype ~= "nofile" then
              vim.cmd("checktime")
            end
          end
        '';
      }
      {
        # Resize window splits when resized.
        event = [ "VimResized" ];
        group = "resize";
        callback = helpers.luaRawExpr ''
          return function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd("tabnext " .. current_tab)
          end
        '';
      }
      {
        # Enable spell checking and word wrap for text files
        event = [ "FileType" ];
        pattern = [
          "*.txt"
          "*.tex"
          "*.typ"
          "gitcommit"
          "markdown"
          "norg"
          "NeogitCommitMessage"
        ];
        group = "textfile";
        callback = helpers.luaRawExpr ''
          return function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end
        '';
      }
      {
        # Disable comment continuation when using `o`.
        event = "BufEnter";
        group = "formatopts";
        callback = helpers.luaRawExpr ''
          return function()
            vim.opt.formatoptions:remove({ "o" })
          end
        '';
      }
    ];
  };
}
