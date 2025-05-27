return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  keys = {
    {
      "w",
      function()
        require("spider").motion("w", { skipInsignificantPunctuation = false })
      end,
      mode = { "n", "o", "x" },
    },
    {
      "W",
      function()
        require("spider").motion("w", { subwordMovement = false })
      end,
      mode = { "n", "o", "x" },
    },
    {
      "e",
      function()
        require("spider").motion("e", { skipInsignificantPunctuation = false })
      end,
      mode = { "n", "o", "x" },
    },
    {
      "E",
      function()
        require("spider").motion("e", { subwordMovement = false })
      end,
      mode = { "n", "o", "x" },
    },
    {
      "b",
      function()
        require("spider").motion("b", { skipInsignificantPunctuation = false })
      end,
      mode = { "n", "o", "x" },
    },
    {
      "B",
      function()
        require("spider").motion("b", { subwordMovement = false })
      end,
      mode = { "n", "o", "x" },
    },
    {
      "cw",
      "c<cmd>lua require('spider').motion('e', { skipInsignificantPunctuation = false })<CR>",
      mode = { "n" },
    },
    {
      "cW",
      "c<cmd>lua require('spider').motion('e', { subwordMovement = false })<CR>",
      mode = { "n" },
    },
    {
      "ce",
      "c<cmd>lua require('spider').motion('e', { skipInsignificantPunctuation = false })<CR>",
      mode = { "n" },
    },
    {
      "cE",
      "c<cmd>lua require('spider').motion('e', { subwordMovement = false })<CR>",
      mode = { "n" },
    },
  },
}
