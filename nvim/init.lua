--                 °#@@@@@#.       *@@@@@@*           °°°°°.
--               O@@@@o.°#@@#   .@@@@@@@@@@@.       °@@@@@@#
--              #@@@@o    @@@  *@@°  o@@@@@@@      *@@@@@@@
--              @@@@@@.  o@@#  @@     *@@@@@@@    o@@@@@@@@
--              @@@@@@@#      #@*     @@@@@@@@o  #@@@@@@@@.
--              @@@@@@@@@*    @@@.    @#@@@@@@@ @@o@@@@@@@
--               @@@@@@@@@#   *@@@@* @@ o@@@@@@@@ O@@@@@@°
--                *@@@@@@@@*   o@@*  @@  @@@@@@@  @@@@@@@
--        .@@@O     @@@@@@@@        @@*  @@@@@@  O@@@@@@o  #
--        @@@@o      @@@@@@@       #@@   #@@@@   @@@@@@@  @@
--       O@@@@       .@@@@@°*#   *@@@    *@@@    @@@@@@@ @@
--       °@@@@       O@@@@@ @@@@@@@@°     @@     o@@@@@@@@.
--        #@@@*     *@@@@O   @@@@@@.      #       *@@@@@o
--         °@@@@@#@@@@@o       °°
--            °o##Oo.
--
--      Personal vim configuration of Sean Meek <sean@seanmeek.com>

----------------------------------------------------------------------------
-- General config
----------------------------------------------------------------------------


require('keymaps')
require('options')
require('plugins')

vim.cmd([[colorscheme dracula]])


----------------------------------------------------------------------------
-- Miscellaneous
----------------------------------------------------------------------------

-- Use neovim's filtype.lua (faster) over filetype.vim for filetype detection
vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

local local_group = vim.api.nvim_create_augroup("Local", { clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
		desc = 'Temporarily highlight text on yank',
		group = local_group,
		pattern = '*',
		callback = function()
			vim.highlight.on_yank { higroup='IncSearch' }
			end,
	})

vim.api.nvim_create_autocmd('BufWritePre', {
		desc = 'Trim whitespace on save',
		group = local_group,
		pattern = '*',
		command = ':%s/\\s\\+$//e',
	})

