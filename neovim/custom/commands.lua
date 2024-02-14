vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Q", "q", {})

local general_group = vim.api.nvim_create_augroup("General settings", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	group = general_group,
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

local ignore_spelling_filetypes = {
	nvcheatsheet = true,
	nvdash = true,
	terminal = true,
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		if ignore_spelling_filetypes[vim.bo.filetype] then
			vim.opt.spell = false
		else
			vim.opt.spell = true
		end
	end,
	group = general_group,
})
