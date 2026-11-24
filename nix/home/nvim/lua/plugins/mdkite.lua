return {
  -- LazyVim's Markdown extra also includes the old preview plugin.
  { "iamcco/markdown-preview.nvim", enabled = false },
  {
    "selimacerbas/mdkite.nvim",
    dependencies = { "selimacerbas/kitehost.nvim" },
    cmd = { "MdKite" },
    keys = {
      {
        "<leader>mp",
        "<cmd>MdKite start<cr>",
        ft = "markdown",
        desc = "Markdown Preview",
      },
      {
        "<leader>ms",
        "<cmd>MdKite stop<cr>",
        ft = "markdown",
        desc = "Stop Markdown Preview",
      },
      {
        "<leader>cp",
        "<cmd>MdKite toggle<cr>",
        ft = "markdown",
        desc = "Markdown Preview",
      },
    },
    main = "mdkite",
    opts = {},
  },
}
