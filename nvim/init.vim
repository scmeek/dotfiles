call plug#begin('~/.vim/plugged')
		" Status bar
		Plug 'hoob3rt/lualine.nvim'
		Plug 'kyazdani42/nvim-web-devicons'

		" Themes
		Plug 'chriskempson/base16-vim'
		" Plug 'gruvbox-community/gruvbox'
		" Plug 'crusoexia/vim-monokai'
		" Plug 'rafi/awesome-vim-colorschemes'

		" LSP and auto completion plugins
		"Plug 'neovim/nvim-lspconfig'
		"Plug 'nvim-lua/completion-nvim'

		" File system explorer - nerdtree
		Plug 'preservim/nerdtree'
		" Plugins
		Plug 'ryanoasis/vim-devicons' " icons
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " file type highlight

		" Parser / syntax highlighting - treesitter
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

		" Fuzzy finder - telecope
		"Plug 'nvim-lua/popup.nvim'
		"Plug 'nvim-lua/plenary.nvim'
		"Plug 'nvim-telescope/telescope.nvim'

		" Misc
		"Plug 'mbbill/undotree' " Visual undo history
		"Plug 'tpope/vim-fugitive' " git wrapper
		Plug 'semanser/vim-outdated-plugins' " check for plugin updates

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
