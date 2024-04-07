return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      -- codelens = { enabled = true },
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
