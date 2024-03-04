return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" } },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" } },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" } },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" } },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "t" } },
    },
  },
}
