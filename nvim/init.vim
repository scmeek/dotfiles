call plug#begin('~/.vim/plugged')
		" Status bar
		Plug 'hoob3rt/lualine.nvim'
		Plug 'kyazdani42/nvim-web-devicons'

		" Themes
		Plug 'chriskempson/base16-vim'
		" Plug 'gruvbox-community/gruvbox'
		" Plug 'crusoexia/vim-monokai'
		" Plug 'rafi/awesome-vim-colorschemes'

		" Auto-completion - deoplete
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
		Plug 'zchee/deoplete-jedi' " Python auto-completion

		" Snippets
		"Plug 'SirVer/ultisnips' " Engine
		"Plug 'honza/vim-snippets' " Snippets

		" File system explorer - nerdtree
		Plug 'preservim/nerdtree'
		" Plugins
		Plug 'ryanoasis/vim-devicons' " icons
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " file type highlight

		" Parser / syntax highlighting - treesitter
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

		" Fuzzy finder - fzf
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
		Plug 'junegunn/fzf.vim'

		" Markdown previewer - markdown-preview
		" If you don't have nodejs and yarn
		" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
		" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
		"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
		" If you have nodejs and yarn
		Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

		" Misc
		"Plug 'mbbill/undotree' " Visual undo history
		Plug 'tpope/vim-fugitive' " git wrapper
		Plug 'airblade/vim-gitgutter' " dit diff in the sign column
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
