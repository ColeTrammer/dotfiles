{ ... }:
{
  programs.nixvim = {
    plugins.lint = {
      enable = true;
      autoCmd = {
        callback = {
          __raw = ''
            function()
              -- Disable with a global or buffer-local variable
              if vim.g.disable_lint or vim.b.disable_lint then
                return
              end
              require('lint').try_lint()
            end
          '';
          desc = "Trigger Linting";
        };
        event = [
          "BufWritePost"
          "BufReadPost"
          "InsertLeave"
        ];
      };
    };
    userCommands = {
      LintToggle = {
        command.__raw = ''
          function(args)
            if args.bang then
              vim.b.disable_lint = not vim.b.disable_lint
            else
              vim.g.disable_lint = not vim.g.disable_lint
            end

            if vim.g.disable_lint or vim.b.disable_lint then
              vim.diagnostic.reset(nil, 0)
            end

            vim.notify(
              "Global Linting Enabled: ["
                .. (vim.g.disable_lint and "" or "")
                .. "]\nBuffer Linting Enabled: ["
                .. (vim.b.disable_lint and "" or "")
                .. "]\n",
              vim.log.levels.info)
          end
        '';
        desc = "Toggle Linting";
        bang = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ul";
        action = "<cmd>LintToggle<cr>";
        options = {
          desc = "Toggle Linting (Global)";
        };
      }
      {
        mode = "n";
        key = "<leader>uL";
        action = "<cmd>LintToggle!<cr>";
        options = {
          desc = "Toggle Linting (Buffer)";
        };
      }
    ];
  };
}
