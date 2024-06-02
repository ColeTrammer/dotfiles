{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      alwaysShowBufferline = false;
      diagnostics = "nvim_lsp";
      diagnosticsIndicator = ''
        function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
              or (e == "warning" and " " or " " )
            s = s .. n .. sym
          end
          return s
        end
      '';
      offsets = [
        {
          filetype = "neo-tree";
          text = "Neo-tree";
          highlight = "Directory";
          text_align = "left";
        }
      ];
    };
    keymaps = [
      {
        key = "<leader>bd";
        mode = "n";
        action = "<cmd>bdelete<cr>";
        options.desc = "Delete Buffer";
      }
      {
        key = "<leader>br";
        mode = "n";
        action = "<cmd>BufferLineCloseRight<cr>";
        options.desc = "Delete Buffers to the Right";
      }
      {
        key = "<leader>bl";
        mode = "n";
        action = "<cmd>BufferLineCloseLeft<cr>";
        options.desc = "Delete Buffers to the Left";
      }
      {
        key = "<leader>bo";
        mode = "n";
        action = "<cmd>BufferLineCloseOthers<cr>";
        options.desc = "Delete Other Buffers";
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "[b";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev Buffer";
      }
    ];
    plugins.which-key.registrations."<leader>b".name = "+buffer";
  };
}
