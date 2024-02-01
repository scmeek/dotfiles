vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Q", "q", {})

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
