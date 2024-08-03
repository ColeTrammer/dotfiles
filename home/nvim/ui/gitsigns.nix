{
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      gitPackage = null;
      settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          delay = 500;
        };
        signs = {
          add = {
            text = "▎";
          };
          change = {
            text = "▎";
          };
          delete = {
            text = "";
          };
          topdelete = {
            text = "";
          };
          changedelete = {
            text = "▎";
          };
          untracked = {
            text = "▎";
          };
        };
        on_attach = ''
          function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, desc)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc, })
            end

            -- Navigation
            map('n', ']h', function()
              gitsigns.nav_hunk('next')
            end, "Next Hunk")

            map('n', '[h', function()
              gitsigns.nav_hunk('prev')
            end, "Prev Hunk")

            -- Actions
            map('n', '<leader>gs', gitsigns.stage_hunk, "Stage Hunk")
            map('n', '<leader>gr', gitsigns.reset_hunk, "Reset Hunk")
            map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Stage Hunk")
            map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Reset Hunk")
            map('n', '<leader>gS', gitsigns.stage_buffer, "Stage Buffer")
            map('n', '<leader>gu', gitsigns.undo_stage_hunk, "Undo Stage Hunk")
            map('n', '<leader>gR', gitsigns.reset_buffer, "Reset Buffer")
            map('n', '<leader>gp', gitsigns.preview_hunk, "Preview Hunk")
            map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, "Blame Line")
            map('n', '<leader>gd', gitsigns.diffthis, "Diff This")
            map('n', '<leader>gD', function() gitsigns.diffthis('~') end, "Diff This ~")

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select Hunk")
          end
        '';
      };
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>g";
        group = "+git";
      }
    ];
  };
}
