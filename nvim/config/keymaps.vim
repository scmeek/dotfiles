" inoremp == i (insert) + nore (no, recurssive calling IMPORTANT) + map

let mapleader = "\<space>"

" Edit configs
nnoremap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nnoremap <leader>vr :source ~/.config/nvim/init.vim<cr>

inoremap kj <Esc> " Go to normal mode

noremap <leader>s :w<CR>
noremap <leader>S :wa<CR>
noremap <leader>q :q<CR>
noremap <leader>Q :q!<CR>

" Close current buffer
noremap <leader>c :bd<CR>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Easier vertical split creation
nnoremap <silent> vv <C-w>v

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Make Y behave like the other capitals
nnoremap Y y$

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

