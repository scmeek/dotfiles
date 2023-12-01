local neorg_open = false
local toggle_neorg = function()
	if neorg_open then
		vim.cmd("Neorg return")
		neorg_open = false
	else
		vim.cmd("Neorg index")
		neorg_open = true
	end
end

return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>N", toggle_neorg, desc = "Toggle [N]eorg" },
		},
		config = function()
			local notes_path = os.getenv("NOTES_PATH")

			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.journal"] = {
						config = { strategy = "flat" },
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

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.norg" },
				command = "set conceallevel=3",
			})
		end,
	},
}
