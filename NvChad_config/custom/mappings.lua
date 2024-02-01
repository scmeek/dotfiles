---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    ["<leader>sf"] = { "ggVG", "select all in file" },
    ["Y"] = { "y$", "yank rest of line" },
    ["<leader>fr"] = {
      function()
        require("telescope.builtin").resume()
      end,
      "resume find"
    },
    ["gp"] = { "`[v`]", "reselect pasted text" },
    ["gt"] = { ":bn<Cr>", "next buffer" },
    ["gT"] = { ":bp<CR>", "previous buffer" },
    ["H"] = { "^", "move to start of line" },  -- corresponding "v" mapping
    ["L"] = { "$", "move to end of line" },  -- corresponding "v" mapping

  },
  v = {
    [">"] = { ">gv", "increase indent"},
    ["<"] = { "<gv", "decrease indent"},
    ["y"] = { "ygv<Esc>", "yank" },
    ["Y"] = { "Ygv<Esc>", "yank" },
    ["H"] = { "^", "move to start of line" },  -- corresponding "n" mapping
    ["L"] = { "$", "move to end of line" },  -- corresponding "n" mapping
    ["J"] = { ":m '>+1<CR>gv==kgvo<esc>=kgvo", "move selected up" },
    ["K"] = { ":m '<-2<CR>gv==jgvo<esc>=jgvo", "move selected down" },
  },
  i = {
    ["<M-BS>"] = { "<Esc>cvb", "backspace entire word" },
  },
}

-- more keybinds!

return M
