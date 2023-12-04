vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>sf", "ggVG", { desc = "[S]elect all text in [F]ile" })
vim.keymap.set("n", "Y", "y$", { desc = "[Y]ank rest of line" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

-- Reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection
vim.keymap.set("v", "y", "ygv<Esc>")
vim.keymap.set("v", "Y", "Ygv<Esc>")

vim.keymap.set("n", "gp", "`[v`]", { desc = "[G]o reselect [P]asted text" })

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.keymap.set("", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { silent = true, expr = true })
vim.keymap.set("", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { silent = true, expr = true })

vim.keymap.set("i", "<M-BS>", "<Esc>cvb", { desc = "Backspace entire word" })

-- Use <Tab> to cycle through buffers in tab
vim.keymap.set("n", "<Tab>", ":bn<CR>", { desc = "Move to next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { desc = "Move to previous buffer", silent = true })
vim.keymap.set("n", "gt", ":bn<CR>", { desc = "Move to next buffer", silent = true })
vim.keymap.set("n", "gT", ":bp<CR>", { desc = "Move to previous buffer", silent = true })

vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Move to start of line" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "Move to end of line" })

vim.keymap.set("n", ";", ":", { desc = "Open command line" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "Move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "Move highlighted text up" })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "<C-q>", "<cmd>quit<CR>")

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
