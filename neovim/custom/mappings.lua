---@type MappingsTable
local M = {}

local constants = require("custom.constants")

M.neovim = {
	n = {
		[":checkhealth"] = { "<nop>", "Run health checks" },
		[":checkhealth <plugin>"] = { "<nop>", "Run health checks for a specific plugin" },
	},
}

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
		[":!sort"] = { "<nop>", "Sort selected text"},
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

M.folds = {
	n = {
		["za"] = { "za", "Toggle fold", opts = { noremap = false } },
		["zd"] = { "zd", "Delete fold", opts = { noremap = false } },
		["zr"] = { "zr", "Reduce (open) all folds by one level", opts = { noremap = false } },
		["zm"] = { "zm", "Fold more (close) all folds by one level", opts = { noremap = false } },
		["zi"] = { "zi", "Change fold method", opts = { noremap = false } },
	},
}

M.marks = {
	n = {
		[":marks"] = { "<nop>", "List marks" },
		["m + {letter}"] = { "<nop>", "Set local mark" },
		["m + {LETTER}"] = { "<nop>", "Set global mark" },
		["` + {mark}"] = { "<nop>", "Move to mark" },
		["' + {mark}"] = { "<nop>", "Move to first character of mark line" },
		["dm + {mark}"] = { "<nop>", "Delete mark" },
		[":delm {marks}"] = { "<nop>", "Delete marks" },
	},
}

M.surround = {
	n = {
		["ys + {motion} + {char}"] = { "<nop>", "Add surround character" },
		["cs + {old char} + {new char}"] = { "<nop>", "Change surround character" },
		["ds + {char}"] = { "<nop>", "Delete surround character" },
	},
}

M.lspconfig = {
	n = {
		["<leader>lf"] = {
			function()
				vim.diagnostic.open_float({
					border = constants.default_border,
					severity_sort = true,
					severity = {
						vim.diagnostic.severity.ERROR,
						vim.diagnostic.severity.WARN,
						--vim.diagnostic.severity.INFO,
						--vim.diagnostic.severity.HINT,
					},
				})
			end,
			"Floating diagnostic",
		},
	},
}

M.nvimtree = {
	n = {
		["c"] = { "c", "Copy file", opts = { noremap = true, silent = true } },
		["p"] = { "p", "Paste", opts = { noremap = true, silent = true } },
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
