return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, 1, {
        filter = { event = "msg_show", find = "[Copilot]" },
        opts = {
          skip = true,
        },
      })
    end,
  },
}
