return {
  "snacks.nvim",
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
