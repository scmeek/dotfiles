"--------------------------------------------------------------------------
" General Config
"--------------------------------------------------------------------------

source ~/.config/nvim/config/keymaps.vim
source ~/.config/nvim/config/sets.vim
source ~/.config/nvim/config/syntax.vim


"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Auto install vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
	" source ~/.config/nvim/plugins/auto-pairs.vim  " quote and bracket auto-completion
	source ~/.config/nvim/plugins/commentary.vim  " comment bindings
	" source ~/.config/nvim/plugins/floaterm.vim  " in-vim terminal
	source ~/.config/nvim/plugins/fugitive.vim  " git wrapper
	source ~/.config/nvim/plugins/fzf.vim  " fuzzy finder
	source ~/.config/nvim/plugins/gitgutter.vim  " git diff in the sign column
	source ~/.config/nvim/plugins/lualine.vim  " status bar
	source ~/.config/nvim/plugins/markdown-preview.vim
	source ~/.config/nvim/plugins/nerdtree.vim  " file system explorer
	source ~/.config/nvim/plugins/outdated-plugins.vim  " check for plugin updates
	source ~/.config/nvim/plugins/polyglot.vim
	source ~/.config/nvim/plugins/surround.vim  " string manipulation
	source ~/.config/nvim/plugins/theme.vim
	source ~/.config/nvim/plugins/tmux-navigator.vim  " integration with tmux
	source ~/.config/nvim/plugins/treesitter.vim  " parser / syntax highlighting
	" source ~/.config/nvim/plugins/undotree.vim  " visual undo history
call plug#end()
doautocmd User PlugLoaded


"--------------------------------------------------------------------------
" Miscellaneous
"--------------------------------------------------------------------------

" Manual whitespace trimming
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun
augroup LOCAL
	autocmd!
	autocmd BufWritePre * :call TrimWhitespace()
augroup END

