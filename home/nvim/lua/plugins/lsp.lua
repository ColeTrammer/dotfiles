return {
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
    },
  },
  -- fix clangd offset encoding
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = {
                command = { "alejandra" },
              },
              nix = {
                maxMemoryMB = 16 * 1024,
                flake = {
                  autoArchive = true,
                  autoEvalInputs = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
