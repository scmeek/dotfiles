return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to previous split" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go down a split" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go up a split" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to next split" },
  },
}
