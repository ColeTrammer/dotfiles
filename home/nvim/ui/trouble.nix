{pkgs, ...}: {
  programs.nixvim = {
    # Use trouble v3 until it gets merged into nixpkgs.
    extraPlugins = [
      (pkgs.vimPlugins.trouble-nvim.overrideAttrs
        {
          version = "3.1.0";
          src = builtins.fetchGit {
            url = "https://github.com/folke/trouble.nvim";
            ref = "main";
            rev = "46a19388d3507f4c4bebb9994bf821a79b3bc342";
          };
        })
    ];
    plugins.lualine.sections.lualine_c = [
      {
        extraConfig.__raw = ''
          (function()
            local trouble = require("trouble")

            -- This is required since trouble would otherwise get loaded after lualine...
            trouble.setup({ use_diagnostic_signs = true, })

            local symbols = trouble.statusline({
              mode = "lsp_document_symbols",
              groups = {},
              title = false,
              filter = { range = true },
              format = "{kind_icon}{symbol.name:Normal}",
              -- The following line is needed to fix the background color
              -- Set it to the lualine section you want to use
              hl_group = "lualine_c_normal",
            })
            return {
              symbols.get,
              cond = symbols.has,
            }
          end)()
        '';
      }
    ];
  };
}
