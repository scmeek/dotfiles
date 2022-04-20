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

require('keymaps')	-- ~/.config/nvim/lua/keymaps.lua
require('options')			-- ~/.config/nvim/lua/options.lua


----------------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------------

-- call plug#begin('~/.vim/plugged')
-- 	source ~/.config/nvim/plugins/commentary.vim		-- Comment bindings
-- 	-- source ~/.config/nvim/plugins/doge.vim				-- Documentation generator
-- 	-- source ~/.config/nvim/plugins/file-explorer.vim
-- 	-- source ~/.config/nvim/plugins/fzf.vim				-- Fuzzy finder
-- 	source ~/.config/nvim/plugins/gitsigns.vim			-- Git diff in the sign column
-- 	source ~/.config/nvim/plugins/lualine.vim			-- Status bar
-- 	-- source ~/.config/nvim/plugins/surround.vim			-- String manipulation
-- 	source ~/.config/nvim/plugins/theme.vim
-- 	source ~/.config/nvim/plugins/tmux-navigator.vim	-- Integration with tmux
-- 	-- source ~/.config/nvim/plugins/treesitter.vim		-- Parser / syntax highlighting
-- 	source ~/.config/nvim/plugins/which-key.vim			-- Keymap assist
-- call plug#end()
-- doautocmd User PlugLoaded

-- https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
-- autocmd VimEnter *
--   \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
--   \|   PlugInstall --sync | q
--   \| endif


----------------------------------------------------------------------------
-- Miscellaneous
----------------------------------------------------------------------------

-- Use neovim's filtype.lua (faster) over filetype.vim for filetype detection
vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

-- TODO: Do these needs augroups?

vim.api.nvim_create_autocmd('TextYankPost', {
		desc = 'Temporarily highlight text on yank',
		pattern = '*',
		callback = function()
			vim.highlight.on_yank { higroup='IncSearch' }
			end,
	})

vim.api.nvim_create_autocmd('BufWritePre', {
		desc = 'Trim whitespace on save',
		pattern = '*',
		command = ':%s/\\s\\+$//e',
	})

