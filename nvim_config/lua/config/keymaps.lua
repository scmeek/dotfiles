local map = vim.keymap.set

-- map("i", "jk", "<ESC>")

-- Movement across soft-wrapped lines
local mux_with_g = function(key)
  local gkey = "g" .. key
  return function()
    if vim.v.count == 0 then
      return gkey
    else
      return key
    end
  end
end
map({ "n", "v" }, "j", mux_with_g("j"), { expr = true })
map({ "n", "v" }, "k", mux_with_g("k"), { expr = true })

-- General
map("n", ";", ":", { desc = "Enter command mode", nowait = true })
map("n", ".", "i", { desc = "Repeat last command", noremap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split horizontal" })
map("n", "<leader>\\", "<C-W>v", { desc = "Split vertical" })
map("v", "<", "<gv", { desc = "Decrease indent" })
map("v", ">", ">gv", { desc = "Increase indent" })
map("v", ":!sort", "<nop>", { desc = "Sort selected text" })
map("i", "<M-BS>", "<Esc>cvb", { desc = "Backspace entire word" })

-- Movement
map("n", "}", "}", { desc = "Move to next paragraph", noremap = false })
map("n", "{", "{", { desc = "Move to previous paragraph", noremap = false })
map("n", "gt", ":bn<Cr>", { desc = "Move to next buffer" })
map("n", "%", "%", { desc = "Move to matching brace" })
map("n", "gT", ":bp<CR>", { desc = "Move to previous buffer" })
map("v", "H", "^", { desc = "Move to start of line" })
map("v", "L", "$", { desc = "Move to end of line" })

-- Text
map("n", "<leader>vw", "ggVG", { desc = "Window" })
map("n", "gp", "`[v`]", { desc = "Re-select pasted text" })
map("n", "Y", "y$", { desc = "Yank rest of line" })
map("v", "Y", "Ygv<Esc>", { desc = "Yank" })
map("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "Swap line (below)" })
map("v", "y", "ygv<Esc>", { desc = "Yank" })
map("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "Swap line (above)" })

-- Folds
map("n", "za", "za", { desc = "Toggle fold", noremap = false })
map("n", "zd", "zd", { desc = "Delete fold", noremap = false })
map("n", "zr", "zr", { desc = "Reduce (open) all folds by one level", noremap = false })
map("n", "zm", "zm", { desc = "Fold more (close) all folds by one level", noremap = false })
map("n", "zi", "zi", { desc = "Change fold method", noremap = false })
