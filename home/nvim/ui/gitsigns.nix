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
          add = {text = "▎";};
          change = {text = "▎";};
          delete = {text = "";};
          topdelete = {text = "";};
          changedelete = {text = "▎";};
          untracked = {text = "▎";};
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
              if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
              else
                gitsigns.nav_hunk('next')
              end
            end, "Next Hunk")

            map('n', '[h', function()
              if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
              else
                gitsigns.nav_hunk('prev')
              end
            end, "Prev Hunk")

            -- Actions
            map('n', '<leader>ghs', gitsigns.stage_hunk, "Stage Hunk")
            map('n', '<leader>ghr', gitsigns.reset_hunk, "Reset Hunk")
            map('v', '<leader>ghs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Stage Hunk")
            map('v', '<leader>ghr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Reset Hunk")
            map('n', '<leader>ghS', gitsigns.stage_buffer, "Stage Buffer")
            map('n', '<leader>ghu', gitsigns.undo_stage_hunk, "Undo Stage Hunk")
            map('n', '<leader>ghR', gitsigns.reset_buffer, "Reset Buffer")
            map('n', '<leader>ghp', gitsigns.preview_hunk, "Preview Hunk")
            map('n', '<leader>ghb', function() gitsigns.blame_line{full=true} end, "Blame Line")
            map('n', '<leader>ghd', gitsigns.diffthis, "Diff This")
            map('n', '<leader>ghD', function() gitsigns.diffthis('~') end, "Diff This ~")

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select Hunk")
          end
        '';
      };
    };
  };
}
