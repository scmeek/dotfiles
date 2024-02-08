---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "Enter command mode", opts = { nowait = true } },
		["."] = { "i", "Repeat last command", opts = { noremap = true } },
		["<leader>\\"] = { "<C-W>v", "Split vertical" },
		["<leader>-"] = { "<C-W>s", "Split horizontal" },
	},
	v = {
		[">"] = { ">gv", "Increase indent" },
		["<"] = { "<gv", "Decrease indent" },
	},
	i = {
		["<M-BS>"] = { "<Esc>cvb", "Backspace entire word" },
	},
}

M.movement = {
	n = {
		["H"] = { "^", "Move to start of line" }, -- corresponding "v" mapping
		["L"] = { "$", "Move to end of line" }, -- corresponding "v" mapping
		["%"] = { "%", "Move to matching brace" },
		["gt"] = { ":bn<Cr>", "Move to next buffer" },
		["gT"] = { ":bp<CR>", "Move to previous buffer" },
		["}"] = { "}", "Move to next paragraph", opts = { noremap = false } },
		["{"] = { "{", "Move to previous paragraph", opts = { noremap = false } },
	},
	v = {
		["H"] = { "^", "Move to start of line" }, -- corresponding "n" mapping
		["L"] = { "$", "Move to end of line" }, -- corresponding "n" mapping
	},
}

M.text_actions = {
	n = {
		["<leader>sf"] = { "ggVG", "Select all in file" },
		["Y"] = { "y$", "Yank rest of line" },
		["gp"] = { "`[v`]", "Re-select pasted text" },
	},
	v = {
		["J"] = { ":m '>+1<CR>gv==kgvo<esc>=kgvo", "Swap line (above)" },
		["K"] = { ":m '<-2<CR>gv==jgvo<esc>=jgvo", "Swap line (below)" },
		["y"] = { "ygv<Esc>", "Yank" },
		["Y"] = { "Ygv<Esc>", "Yank" },
	},
}

M.macros = {
	n = {
		["q + {letter}"] = { "<nop>", "Record macro" },
		["q"] = { "q", "Stop recording macro", opts = { noremap = false } },
		["@ + {letter}"] = { "<nop>", "Run macro" },
		["@@"] = { "@@", "Re-run last ran macro", opts = { noremap = false } },
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
