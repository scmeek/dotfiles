call plug#begin('~/.vim/plugged')
		" Plug 'gruvbox-community/gruvbox'
		" Plug 'crusoexia/vim-monokai'
		Plug 'rafi/awesome-vim-colorschemes'

		Plug 'hoob3rt/lualine.nvim'

		Plug 'ryanoasis/vim-devicons'

		" LSP and auto completion plugins
		Plug 'neovim/nvim-lspconfig'
		Plug 'nvim-lua/completion-nvim'

		" telecope
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'

		" treesitter
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

		" undo tree
		" fugitive
call plug#end()

fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

augroup LOCAL
	autocmd!
	autocmd BufWritePre * :call TrimWhitespace()
augroup END
