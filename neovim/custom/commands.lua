vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("Highlight on yank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_user_command("ToggleVerboseLogging", function()
	if vim.opt.verbose:get() == 0 then
		print("Enabling verbose logging")
		vim.opt.verbosefile = vim.fn.expand("~/log/vim/verbose.log")
		vim.opt.verbose = 15
	else
		print("Disabling verbose logging")
		vim.opt.verbose = 0
		vim.opt.verbosefile = nil
	end
end, {})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("Disable spell", { clear = true }),
	pattern = {
		"lspinfo",
		"noice",
		"nvcheatsheet",
		"nvdash",
		"NvimTree",
		"TelescopePrompt",
		"TelescopeResults",
		"terminal",
		"WhichKey",
	},
	callback = function()
		vim.opt.spell = false
	end,
})
