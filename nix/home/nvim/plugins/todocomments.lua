return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  opts = {
    keywords = {
      TODO = {
        alt = { "todo!" },
      },
    },
    merge_keywords = true,
    highlight = {
      keyword = "bg",
      after = "",
      pattern = [[(KEYWORDS)]],
      comments_only = false,
    },
    search = {
      pattern = [[\b(KEYWORDS)]],
    },
  },
}
