-- Also configured in cmp
return {
	"zbirenbaum/copilot.lua",
	event = "VeryLazy",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		cmp = {
			enabled = true,
			method = "getCompletionsCycling",
		},
		filetypes = {
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		},
		server_opts_overrides = {
			settings = {
				advanced = {
					inlineSuggestCount = 3,
				},
			},
		},
	},
}
