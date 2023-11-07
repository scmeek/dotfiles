local constants = require("constants")
local icons = require("icons")

return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	opts = {
		signs = true,
		sign_priority = 8,
		keywords = {
			FIX = {
				icon = icons.todo.fix,
				color = "error",
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
			},
			TODO = { icon = icons.todo.todo, color = "info" },
			HACK = { icon = icons.todo.hack, color = "warning" },
			WARN = { icon = icons.todo.warning, color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = icons.todo.performance, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = icons.todo.note, color = "hint", alt = { "INFO" } },
			TEST = { icon = icons.todo.test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		merge_keywords = true,
		highlight = {
			multiline = true,
			multiline_pattern = "^.",
			multiline_context = 10,
			before = "",
			keyword = "wide",
			after = "fg",
			pattern = [[.*<(KEYWORDS)\s*:]],
			comments_only = true,
			max_line_len = 400,
			exclude = {},
		},
		colors = {
			error = { "DiagnosticError", "ErrorMsg", constants.backup_colors.error },
			warning = { "DiagnosticWarn", "WarningMsg", constants.backup_colors.warning },
			info = { "DiagnosticInfo", constants.backup_colors.info },
			hint = { "DiagnosticHint", constants.backup_colors.hint },
			default = { "Identifier", constants.backup_colors.default },
			test = { "Identifier", constants.backup_colors.test },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			pattern = [[\b(KEYWORDS):]],
		},
	},
}
