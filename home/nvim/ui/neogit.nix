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
        options = {
          desc = "Git";
        };
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
        options = {
          desc = "Git Log (File)";
        };
      }
    ];
  };
}
