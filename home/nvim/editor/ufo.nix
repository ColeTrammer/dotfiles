{
  programs.nixvim = {
    plugins.nvim-ufo = {
      enable = true;
    };
    plugins.lsp.capabilities = ''
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        }
      )
    '';
    keymaps = [
      {
        mode = "n";
        key = "zR";
        action.__raw = ''function() require("ufo").openAllFolds() end'';
        options = {
          desc = "Open All Folds";
        };
      }
      {
        mode = "n";
        key = "zM";
        action.__raw = ''function() require("ufo").closeAllFolds() end'';
        options = {
          desc = "Close All Folds";
        };
      }
    ];
  };
}
