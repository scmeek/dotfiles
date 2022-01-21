"                 °#@@@@@#.       *@@@@@@*           °°°°°.
"               O@@@@o.°#@@#   .@@@@@@@@@@@.       °@@@@@@#
"              #@@@@o    @@@  *@@°  o@@@@@@@      *@@@@@@@
"              @@@@@@.  o@@#  @@     *@@@@@@@    o@@@@@@@@
"              @@@@@@@#      #@*     @@@@@@@@o  #@@@@@@@@.
"              @@@@@@@@@*    @@@.    @#@@@@@@@ @@o@@@@@@@
"               @@@@@@@@@#   *@@@@* @@ o@@@@@@@@ O@@@@@@°
"                *@@@@@@@@*   o@@*  @@  @@@@@@@  @@@@@@@
"        .@@@O     @@@@@@@@        @@*  @@@@@@  O@@@@@@o  #
"        @@@@o      @@@@@@@       #@@   #@@@@   @@@@@@@  @@
"       O@@@@       .@@@@@°*#   *@@@    *@@@    @@@@@@@ @@
"       °@@@@       O@@@@@ @@@@@@@@°     @@     o@@@@@@@@.
"        #@@@*     *@@@@O   @@@@@@.      #       *@@@@@o
"         °@@@@@#@@@@@o       °°
"            °o##Oo.
"
"      Personal vim configuration of Sean Meek <sean@seanmeek.com>

"--------------------------------------------------------------------------
" General config
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
	source ~/.config/nvim/plugins/coc.vim  " Completiong engine (LSP)
	source ~/.config/nvim/plugins/comfortable-motion.vim  " Smooth scrolling
	source ~/.config/nvim/plugins/commentary.vim  " Comment bindings
	source ~/.config/nvim/plugins/doge.vim  " Documentation generator
	source ~/.config/nvim/plugins/floaterm.vim  " In-vim terminal
	source ~/.config/nvim/plugins/fzf.vim  " Fuzzy finder
	source ~/.config/nvim/plugins/gitgutter.vim  " Git diff in the sign column
	source ~/.config/nvim/plugins/lualine.vim  " Status bar
	source ~/.config/nvim/plugins/nerdtree.vim  " File system explorer
	source ~/.config/nvim/plugins/outdated-plugins.vim  " Check for plugin updates
	source ~/.config/nvim/plugins/polyglot.vim
	source ~/.config/nvim/plugins/surround.vim  " String manipulation
	source ~/.config/nvim/plugins/theme.vim
	source ~/.config/nvim/plugins/tmux-navigator.vim  " Integration with tmux
	source ~/.config/nvim/plugins/treesitter.vim  " Parser / syntax highlighting
	source ~/.config/nvim/plugins/which-key.vim
call plug#end()
doautocmd User PlugLoaded

" https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


"--------------------------------------------------------------------------
" Miscellaneous
"--------------------------------------------------------------------------

au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }

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

