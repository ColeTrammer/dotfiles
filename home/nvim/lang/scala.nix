{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs; [
      vimPlugins.nvim-metals
    ];
    extraConfigLua = ''
      local metals = require("metals")
      local metals_config = vim.tbl_deep_extend("force", metals.bare_config(), {
        on_attach = function(client, bufnr)
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          vim.keymap.set("n", "<leader>cm", function()
            require("telescope").extensions.metals.commands()
          end, { buffer = bufnr, desc = "Metals Commands" })
          vim.keymap.set("n", "<leader>cc", function()
            require("metals").compile_cascade()
          end, { buffer = bufnr, desc = "Metals Compile Cascade" })

          metals.setup_dap(client, bufnr)
        end,
        init_options = {
          statusBarProvider = "off",
        },
        settings = {
          showImplicitArguments = true,
          metalsBinaryPath = "${pkgs.metals}/bin/metals",
        },
      })

      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
          metals.initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    '';
  };

  home.packages = with pkgs; [
    coursier
  ];
}
