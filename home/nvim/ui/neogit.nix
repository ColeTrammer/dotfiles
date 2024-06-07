{
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
    };
    keymaps = [
      {
        key = "<leader>gg";
        action = {
          __raw = ''
            function()
              local neogit = require('neogit')
              neogit.open()
            end
          '';
        };
        mode = "n";
        options = {desc = "Git";};
      }
      {
        key = "<leader>gc";
        action = {
          __raw = ''
            function()
              local neogit = require('neogit')
              neogit.open({ "commit" })
            end
          '';
        };
        mode = "n";
        options = {desc = "Git Commit";};
      }
      {
        key = "<leader>gf";
        action = {
          __raw = ''
            function()
              local file = vim.fn.expand("%")
              local neogit = require('neogit')
              neogit.action("log", "log_current", { "--", file, })()
            end
          '';
        };
        mode = "n";
        options = {desc = "Git Log (File)";};
      }
    ];
  };
}
