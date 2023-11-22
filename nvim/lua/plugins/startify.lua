return {
	"mhinz/vim-startify",
	config = function()
		vim.g.startify_custom_header = {
			[[                                                                       ]],
			[[  ██████   █████                   █████   █████  ███                  ]],
			[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
			[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
			[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
			[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
			[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
			[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
			[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
			[[                                                                       ]],
		}

		vim.g.startify_change_to_dir = 0
		vim.g.startify_change_to_vcs_root = 1
		vim.g.startify_enable_special = 0
		vim.g.startify_enable_unsafe = 1
		vim.g.startify_files_number = 5
		vim.g.startify_skiplist = { "COMMIT_EDITMSG", ".DS_Store" }
		vim.g.startify_use_env = 1

		indices = {}
		for i = 1, 100 do
			indices[i] = i
		end
		vim.g.startify_custom_indices = indices

		vim.g.startify_bookmarks = {
			os.getenv("DOTFILES_PATH"),
		}

		vim.g.startify_commands = {
			{ "Lazy sync",    "Lazy sync" },
			{ "Mason update", "MasonUpdate" },
		}

		vim.g.startify_lists = {
			{ type = "bookmarks", header = { "   Bookmarks" } },
			{
				type = "dir",
				header = {
					"   Recently used - " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
				},
			},
			{ type = "files",     header = { "   Recently used" } },
			{ type = "commands",  header = { "   Commands" } },
		}

		function _G.webDevIcons(path)
			local filename = vim.fn.fnamemodify(path, ":t")
			local extension = vim.fn.fnamemodify(path, ":e")
			return require("nvim-web-devicons").get_icon(filename, extension, { default = true })
		end

		vim.api.nvim_exec(
			[[
				function! StartifyEntryFormat() abort
					return "v:lua.webDevIcons(absolute_path) . ' ' . entry_path"
				endfunction
			]],
			false
		)
	end,
}
