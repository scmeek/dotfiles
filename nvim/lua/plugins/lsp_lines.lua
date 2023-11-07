local lsp_lines_enabled = true
function ToggleLspLines()
	lsp_lines_enabled = not lsp_lines_enabled
	if lsp_lines_enabled then
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = {
				only_current_line = true,
				highlight_whole_line = false,
			},
		})
	else
		vim.diagnostic.config({
			virtual_text = true,
			virtual_lines = false,
		})
	end
end

return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	lazy = false,
	keys = {
		{ "<leader>l", ToggleLspLines, desc = "Toggle [L]SP lines" },
	},
	config = function()
		require("lsp_lines").setup()
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = {
				only_current_line = true,
				highlight_whole_line = false,
			},
		})
	end,
}
