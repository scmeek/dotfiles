---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "Enter command mode", opts = { nowait = true } },
		["<leader>sf"] = { "ggVG", "Select all in file" },
		["Y"] = { "y$", "Yank rest of line" },
		["gp"] = { "`[v`]", "Re-select pasted text" },
		["gt"] = { ":bn<Cr>", "Move to next buffer" },
		["gT"] = { ":bp<CR>", "Move to previous buffer" },
		["H"] = { "^", "Move to start of line" }, -- corresponding "v" mapping
		["L"] = { "$", "Move to end of line" }, -- corresponding "v" mapping
		["<leader>\\"] = { "<C-W>v", "Split vertical" },
		["<leader>-"] = { "<C-W>s", "Split horizontal" },
	},
	v = {
		[">"] = { ">gv", "Increase indent" },
		["<"] = { "<gv", "Decrease indent" },
		["y"] = { "ygv<Esc>", "Yank" },
		["Y"] = { "Ygv<Esc>", "Yank" },
		["H"] = { "^", "Move to start of line" }, -- corresponding "n" mapping
		["L"] = { "$", "Move to end of line" }, -- corresponding "n" mapping
		["J"] = { ":m '>+1<CR>gv==kgvo<esc>=kgvo", "Move selected up" },
		["K"] = { ":m '<-2<CR>gv==jgvo<esc>=jgvo", "Move selected down" },
	},
	i = {
		["<M-BS>"] = { "<Esc>cvb", "Backspace entire word" },
	},
}

M.telescope = {
	n = {
		["<leader>fr"] = {
			function()
				require("telescope.builtin").resume()
			end,
			"Resume find",
		},
	},
}

M.nvterm = {
	n = {
		["<leader>t-"] = {
			function()
				require("nvterm.terminal").new("horizontal")
			end,
			"New horizontal term",
		},

		["<leader>t\\"] = {
			function()
				require("nvterm.terminal").new("vertical")
			end,
			"New vertical term",
		},
	},
}

return M
