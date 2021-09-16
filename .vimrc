syntax on			" basic syntax highlighting

set noerrorbells	" no sound
set tabstop=4		" character length
set softtabstop=4	" spaces length
set shiftwidth=4    " arrow key moves line over character length
"set expandtab		" convert tabs to spaces
set smartindent		" try to indent intelligently
set nu			    " line numbers
set nowrap		    " do not wrap overflown lines
set smartcase		" search case insensitive until upper case entered
set noswapfile		" no vim swap files for editing
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch		" search while typing
set nohlsearch		" do not highlight search

set copyindent
set preserveindent
set autoindent

set number relativenumber	" hybrid line numbers on

inoremap jj <Esc>	" jj escapes insert mode

set colorcolumn=80
high ColorColumn ctermbg=0 guibg=lightgrey
