---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "Enter command mode", opts = { nowait = true } },

		-- format with conform
		["<leader>fm"] = {
			function()
				require("conform").format()
			end,
			"Format",
		},

		["<leader>sf"] = { "ggVG", "Select all in file" },
		["Y"] = { "y$", "Yank rest of line" },
		["<leader>fr"] = {
			function()
				require("telescope.builtin").resume()
			end,
			"Resume find",
		},
		["gp"] = { "`[v`]", "Re-select pasted text" },
		["gt"] = { ":bn<Cr>", "Move to next buffer" },
		["gT"] = { ":bp<CR>", "Move to previous buffer" },
		["H"] = { "^", "Move to start of line" }, -- corresponding "v" mapping
		["L"] = { "$", "Move to end of line" }, -- corresponding "v" mapping

		["<leader>t\\"] = {
			function()
				require("nvterm.terminal").new("horizontal")
			end,
			"New horizontal term",
		},

		["<leader>t-"] = {
			function()
				require("nvterm.terminal").new("vertical")
			end,
			"New vertical term",
		},

		["<leader>\\"] = { "<C-W>v", "Split vertical" },
		["<leader>-"] = { "<C-W>s", "Split horizontal" },

		-- tmux navigator
		["<C-h>"] = { "<C-W>h", "Move to previous split" },
		["<C-j>"] = { "<C-W>j", "Move to lower split" },
		["<C-k>"] = { "<C-W>k", "Move to upper split" },
		["<C-l>"] = { "<C-W>l", "Move to next split" },
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
		["<M-BS>"] = { "<Esc>cvb", "backspace entire word" },
	},
}

-- more keybinds!

return M
