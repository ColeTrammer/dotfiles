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
  };
}
