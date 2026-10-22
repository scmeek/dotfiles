-- Sort discovery too: live grep can stop at its result limit before UI sorting.
local function search_source(args)
  return {
    hidden = true,
    args = args or { "--sort=path" },
    matcher = {
      sort_empty = true,
      frecency = false,
      history_bonus = false,
      cwd_bonus = false,
    },
    -- rg's sorted discovery index breaks ties within a file in line order.
    sort = { fields = { "score:desc", "file", "idx" } },
  }
end

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
        files = vim.tbl_extend("force", search_source(), { cmd = "rg" }),
        grep = search_source(),
        grep_word = search_source({ "--word-regexp", "--sort=path" }),
      },
    },
    dashboard = {
      preset = {
        header = "Neovim",
      },
    },
  },
}
