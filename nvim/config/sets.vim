" :h <option> for details
" :options lists all

set tabstop=4
set softtabstop=4
set shiftwidth=4
" set expandtab
set smartindent
set copyindent
set preserveindent
set autoindent

set nocompatible
set showmatch
set exrc
set relativenumber
set nu
set nohlsearch
" set hidden  " Enabled by default in neovim 0.6
set noerrorbells
set nowrap
set smartcase
set ignorecase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set sidescrolloff=8
set colorcolumn=80
set signcolumn=auto
set noshowmode
set completeopt=menuone,noinsert,noselect
set wildmode=longest,list,full
set wildmenu
set inccommand=split  " Live substitution
set showbreak=↪\
set list
set listchars=tab:\|\ ,trail:·
set mouse=a
set clipboard=unnamedplus
set confirm
set backup
set backupdir=~/.vim/backup
set wrap
set linebreak
set timeoutlen=500

" improves:
" - gitgutter responsiveness
" - vim swap file
" - coc hover time
set updatetime=50

" More natural split opening
set splitbelow
set splitright

