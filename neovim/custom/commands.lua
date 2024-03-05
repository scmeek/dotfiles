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
	"lspinfo",
	"nvcheatsheet",
	"nvdash",
	"NvimTree",
	"TelescopePrompt",
	"TelescopeResults",
	"terminal",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		local spell = true
		for _, filetype in pairs(ignore_spelling_filetypes) do
			if vim.bo.filetype == filetype then
				spell = false
				break
			end
		end
		vim.opt.spell = spell
	end,
	group = general_group,
})
