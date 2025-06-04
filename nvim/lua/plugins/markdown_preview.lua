local map = vim.keymap.set

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  ft = { "markdown" },
  config = function()
    map("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "markdown-preview open" })
    map("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "markdown-preview stop" })
  end,
}
