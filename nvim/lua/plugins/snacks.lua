return {
  "snacks.nvim",
  keys = {
    {
      "<leader><space>",
      LazyVim.pick("files", { root = false }),
      desc = "Find Files (cwd)",
    },
    {
      "<leader>ff",
      LazyVim.pick("files", { root = false }),
      desc = "Find Files (cwd)",
    },
    {
      "<leader>/",
      LazyVim.pick("grep", { root = false }),
      desc = "Grep (cwd)",
    },
    {
      "<leader>//",
      LazyVim.pick("grep", { root = false }),
      desc = "Grep (cwd)",
    },
    {
      "<leader>sg",
      LazyVim.pick("live_grep", { root = false }),
      desc = "Grep (cwd)",
    },
    {
      "<leader>sw",
      LazyVim.pick("grep_word", { root = false }),
      desc = "Visual selection or word (cwd)",
      mode = { "n", "x" },
    },
  },
  opts = {
    picker = {
      -- Alt+h toggles hidden files; Alt+i toggles ignored files.
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
        grep_word = { hidden = true },
      },
    },
    dashboard = {
      preset = {
        header = "Neovim",
      },
    },
  },
}
