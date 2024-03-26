return {
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", opts = {
    ensure_installed = {},
  } },
  { "williamboman/mason-nvim-dap.nvim", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      for server, server_opts in pairs(opts.servers) do
        server_opts.mason = false
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Disable default behavior of using mason.
    end,
  },
}
