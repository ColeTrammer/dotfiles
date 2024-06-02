{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      preConfig = ''
        -- Setup diagnostics.
        vim.diagnostic.config({
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = function(diagnostic)
              if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return " "
              elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                return " "
              elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                return " "
              elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                return " "
              else
                return "●"
              end
            end,
          },
          severity_sort = true,
        })
      '';
      capabilities = ''
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities(), {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        })
      '';
      onAttach = ''
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      '';
    };
  };
}
