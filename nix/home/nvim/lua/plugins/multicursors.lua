return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  cmd = {
    "MCstart",
    "MCvisual",
    "MCclear",
    "MCpattern",
    "MCvisualPattern",
    "MCunderCursor",
  },
  keys = {
    {
      mode = { "n" },
      "<leader>m",
      "<cmd>MCstart<cr>",
      desc = "Enter multicursor mode",
    },
    {
      mode = { "v" },
      "m",
      "<cmd>MCstart<cr>",
      desc = "Enter multicursor mode",
    },
  },
  opts = {},
}
