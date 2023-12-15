return {
	"levouh/tint.nvim",
	event = "VeryLazy",
	config = function()
		require("tint").setup({
			tint = -20,
			window_ignore_function = function(winid)
				local bufid = vim.api.nvim_win_get_buf(winid)
				local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
				local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

				local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
				local ignore_filetypes = {
					["neo-tree"] = true,
					["startify"] = true,
				}

				return buftype == "terminal" or floating or ignore_filetypes[filetype]
			end,
		})
	end,
}
