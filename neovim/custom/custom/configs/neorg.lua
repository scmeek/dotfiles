local toggle_neorg = function(journal_day)
	if journal_day ~= nil then
		vim.cmd("Neorg journal " .. journal_day)
		return
	end
	if vim.bo.filetype ~= "norg" then
		vim.cmd("Neorg index")
	else
		vim.cmd("Neorg return")
	end
end

return {
	{
		"nvim-neorg/neorg",
		event = "VeryLazy",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>nn",
				function()
					toggle_neorg()
				end,
				desc = "Toggle [N]eorg [N]otes",
			},
			{
				"<leader>nt",
				function()
					toggle_neorg("today")
				end,
				desc = "Toggle [N]eorg Journal [T]oday",
			},
			{
				"<leader>ny",
				function()
					toggle_neorg("yesterday")
				end,
				desc = "Toggle [N]eorg Journal [Y]esterday",
			},
		},
		config = function()
			local notes_path = os.getenv("NOTES_PATH")

			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.journal"] = {
						config = { strategy = "flat" },
					},
					["core.keybinds"] = {
						config = {
							hook = function(keybinds)
								keybinds.remap_key("norg", "n", "<C-Space>", "<LocalLeader>c")
							end,
						},
					},
					["core.qol.toc"] = {
						config = { close_after_use = true },
					},
					["core.concealer"] = {
						config = { icon_preset = "diamond" },
					},
					["core.completion"] = {
						config = { engine = "nvim-cmp" },
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								personal = notes_path .. "/neorg/personal",
								work = notes_path .. "/neorg/work",
							},
							default_workspace = "personal",
						},
					},
					["core.summary"] = {},
				},
			})

			require("which-key").register({
				["<leader>n"] = { name = "[N]eorg", _ = "which_key_ignore" },
			})

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.norg" },
				command = "set conceallevel=3",
			})
		end,
	},
}
