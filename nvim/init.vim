call plug#begin('~/.vim/plugged')
		" Plug 'gruvbox-community/gruvbox'
		" Plug 'crusoexia/vim-monokai'
		" Plug 'rafi/awesome-vim-colorschemes'
		" Plug 'chriskempson/base16-vim'

		Plug 'hoob3rt/lualine.nvim'
		Plug 'kyazdani42/nvim-web-devicons'

		Plug 'ryanoasis/vim-devicons'

		" LSP and auto completion plugins
		Plug 'neovim/nvim-lspconfig'
		Plug 'nvim-lua/completion-nvim'

		" treesitter
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

		" telecope
		Plug 'nvim-lua/popup.nvim'
		Plug 'nvim-lua/plenary.nvim'
		Plug 'nvim-telescope/telescope.nvim'

		Plug 'mbbill/undotree'
		Plug 'tpope/vim-fugitive'

		Plug 'semanser/vim-outdated-plugins'
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
